# 22.04
FROM --platform=linux/amd64 ubuntu@sha256:c985bc3f77946b8e92c9a3648c6f31751a7dd972e06604785e47303f4ad47c4c
ARG TARGETOS=linux
ARG TARGETARCH=amd64
ARG UID=501
ARG GID=20
ARG USER=sighup
ARG ASDF_VERSION=v0.11.1
ARG DIRENV_VERSION=2.28.0

USER root

RUN apt update
RUN apt install -y make \
    git \
    git-crypt \
    gpg \
    zsh \
    vim \
    neovim \
    curl \
    unzip \
    gzip



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

ENTRYPOINT [ "zsh" ]


