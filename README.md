# Stack Sculptor

Introducing StackSculptor - a tool designed to standardize the working environment for all people involved in Kubernetes cluster operations, simplify tool management using asdf, and support the AMD64 architecture, including M1 Mac.

StackSculptor aims to provide a consistent and reliable environment for Kubernetes cluster operations, regardless of the platform or hardware used. With StackSculptor, users can easily manage their tooling stack and dependencies using asdf, a universal version manager that makes it easy to install, manage, and switch between different versions of tools such as kubectl, helm, and terraform.

By leveraging asdf, StackSculptor ensures that all users have the same version of each tool, avoiding compatibility issues or conflicts. Additionally, StackSculptor supports the AMD64 architecture and can be used on M1 Macs, providing a seamless experience across different hardware platforms.

StackSculptor's main features include:

- Standardized environment: StackSculptor ensures that all users have the same versions of tools, avoiding compatibility issues or conflicts.
- Simplified tool management: Users can easily install, manage, and switch between different versions of tools using asdf.
- Multi-architecture support: StackSculptor supports the AMD64 architecture and can be used on M1 Macs, providing a seamless experience across different hardware platforms.
Overall, StackSculptor is a powerful tool that simplifies Kubernetes cluster operations, provides a consistent environment, and streamlines tool management. Whether you're a developer, operator, or administrator, StackSculptor can help you optimize your workflow and improve your productivity.

# Features to be implemented:

- [x] A linux/amd64 based command line that includes all the SIGHUP tools
- [x] Preinstalled tools
  - [x] asdf
    - [x] jq
    - [x] yq
    - [x] kustomize
    - [x] kubectl
    - [x] helm
    - [x] helmfile
    - [x] terraform
    - [x] deck
    - [x] furyctl
    - [x] direnv
    - [x] awscli
    - [x] gcloud
    - [x] k9s
    - [x] stern
    - [x] kubectx
  - [x] make
  - [x] ansible
  - [x] oci cli
  - [x] git
  - [x] git-crypt
  - [x] gpg
  - [x] zsh + oh-my-zsh
  - [x] vim/neovim
  - [x] furyagent
  - [x] azcli
- [ ] Precustomized prompt with kubernetes context
- [x] Match uid with host
- [x] Mount your own source code

# How to use

Requirements:

- TBD
