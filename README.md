# SteamFork&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;[![Latest Version](https://img.shields.io/github/release/SteamFork/distribution.svg?color=1384B5&label=latest%20version&style=flat-square)](https://github.com/SteamFork/distribution/releases/latest) ![Build Status](https://img.shields.io/github/actions/workflow/status/SteamFork/distribution/release.yml?color=1384B5) [![Activity](https://img.shields.io/github/commit-activity/m/SteamFork/distribution?color=1384B5&style=flat-square)](https://github.com/SteamFork/distribution/commits) [![Discord](https://img.shields.io/discord/1245092101193072650?color=1384B5&label=chat&style=flat-square)](https://discord.gg/AQ5rtQstCf)

SteamFork is a SteamOS-based operating system with improved hardware compatibility. It is designed to provide the same experience as SteamOS on a SteamDeck.

## Documentation
Visit the SteamFork Organization root for basic information and usage instructions:
  - [SteamFork Organization](https://github.com/SteamFork)

## Build Features
* Fully automated CI/CD based releases triggered by new release tags.
* Signed package repositories.
* Minimal changes from upstream SteamOS for compatibility.
* Simplified build process as described below.

## Building SteamFork
### Installing Minimal SteamFork
Install SteamFork using the [release image](https://www.steamfork.org/images/installer/) or build the minimal image using an existing SteamFork installation by checking out this repository and executing `make image minimal`.  Building the OS requires ~20GB of free space.  To install a minimal SteamFork instance using the minimal image, boot the image and then install using the `steamfork-installer` tool.

Ex. `steamfork-installer --drive /dev/sda --username builder --password SteamFork --root_password SteamFork`

### Building Images
Log in as your user and perform the following steps to configure the OS for building:
1. Clone the SteamFork distribution repository: `git clone https://github.com/SteamFork/distribution --depth=1`
2. Build SteamFork: `cd distribution && make image rel`

Optional:
1. Enable SSH for remote access: `sudo steamos-readonly disable && sudo systemctl enable sshd`
