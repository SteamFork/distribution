# SteamFork
SteamFork is a personal project to create an immutable Linux distribution that is as SteamOS like as possible without sacrificing device compatibility.

## Documentation
Visit the SteamFork Organization root for basic information and usage instructions:
  - [SteamFork Organization](https://github.com/SteamFork)

## Building SteamFork
### Installing Minimal SteamFork
Install SteamFork using the release or minimal image onto a PC or in a virtual machine.  Building the OS requires ~20GB of free space.  To install a minimal SteamFork instance using the minimal image, boot the image and then install using the `steamfork-installer` tool.

Ex. `steamfork-installer --drive /dev/sda --username builder --password SteamFork --root_password SteamFork`

### Building Images
Log in as your user and perform the following steps to configure the OS for building:
1. Configure sudo without a password: `sudo sed -i 's~ALL$~NOPASSWD: ALL~g' /etc/sudoers.d/wheel`
2. Clone the SteamFork distribution repository: `git clone https://github.com/SteamFork/distribution.git`
3. Build SteamFork: `cd distribution && ./build-image.sh rel`

Optional:
1. Enable SSH for remote access: `sudo steamos-readonly disable && sudo systemctl enable sshd`
