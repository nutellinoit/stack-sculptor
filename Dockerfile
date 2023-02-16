FROM --platform=linux/amd64 ubuntu@sha256:c985bc3f77946b8e92c9a3648c6f31751a7dd972e06604785e47303f4ad47c4c as furyagent
ARG FURYAGENT_VERSION=v0.3.0

RUN apt update
RUN apt install -y curl

RUN curl -sSL  https://github.com/sighupio/furyagent/releases/download/${FURYAGENT_VERSION}/furyagent-linux-amd64.tar.gz | tar xz -C /usr/bin
RUN chmod +x /usr/bin/furyagent

# 22.04
FROM --platform=linux/amd64 ubuntu@sha256:c985bc3f77946b8e92c9a3648c6f31751a7dd972e06604785e47303f4ad47c4c
ARG TARGETOS=linux
ARG TARGETARCH=amd64
ARG UID=501
ARG GID=20
ARG USER=sighup
ARG ASDF_VERSION=v0.11.1
ARG DIRENV_VERSION=2.28.0
ARG ANSIBLE_VERSION=2.10.7

USER root

RUN apt update
RUN apt install -y \
    make \
    git \
    git-crypt \
    gpg \
    zsh \
    vim \
    neovim \
    curl \
    unzip \
    gzip \
    python3-pip \
    python3.10-venv	

RUN ln -s $(which python3) /usr/local/bin/python

ENV HOME=/home/sighup
RUN useradd -m -u $UID -N -g $GID -s /bin/zsh -d $HOME $USER

USER $USER
WORKDIR $HOME

# Install oh my zsh
RUN sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
COPY --chown=$UID:$GID .zshrc $HOME/.zshrc
# Install asdf
RUN git clone https://github.com/asdf-vm/asdf.git $HOME/.asdf --branch $ASDF_VERSION

ENV PATH=$PATH:$HOME/.asdf/bin

COPY asdf_plugins $HOME/.asdf_plugins

RUN for plugin in $(cat $HOME/.asdf_plugins); do asdf plugin add $plugin; done;
RUN asdf install direnv $DIRENV_VERSION
RUN asdf global direnv $DIRENV_VERSION

RUN echo 'eval "$(asdf exec direnv hook zsh)"' >> $HOME/.zshrc
RUN asdf direnv setup --shell zsh --version $DIRENV_VERSION

COPY --chown=$UID:$GID .envrc $HOME/.envrc
COPY --chown=$UID:$GID .tool-versions $HOME/.tool-versions

RUN asdf install
RUN asdf exec direnv allow

RUN pip3 install "ansible==${ANSIBLE_VERSION}"
COPY --from=furyagent /usr/bin/furyagent /usr/local/bin/furyagent
RUN curl -sSL https://raw.githubusercontent.com/oracle/oci-cli/master/scripts/install/install.sh -o /tmp/oci-cli-install.sh && chmod +x /tmp/oci-cli-install.sh && /tmp/oci-cli-install.sh --accept-all-defaults && rm /tmp/oci-cli-install.sh

ENTRYPOINT [ "zsh" ]


