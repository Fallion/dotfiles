# dotfiles
My dotfiles inspired from https://github.com/ridhwaans/dotfiles

## prerequisites

### macOS

GET High Sierra Update https://www.apple.com/ca/macos/how-to-upgrade/
GET Xcode Command Line Tools xcode-select --install

### windowsOS

GET Windows 10 Creators Update https://support.microsoft.com/en-ca/help/4028685/windows-10-get-the-fall-creators-update
GET Windows Subsystem for Linux https://docs.microsoft.com/en-us/windows/wsl/install-win10
GET ubuntuOS Ubuntu 17.10 (Artful Aardvark)

## installation

git

git clone git@github.com:fallion/dotfiles.git ~/dotfiles
cd ~/dotfiles
sh setup.sh


### Remote

#### curl

`curl -fsSL https://raw.github.com/Fallion/dotfiles/master/remote-setup.sh | bash`


#### wget

`wget -O - --no-check-certificate https://raw.githubusercontent.com/Fallion/dotfiles/master/remote-setup.sh | bash`

# Windows install

For apps
`Set-ExecutionPolicy Bypass -Scope Process -Force; iex ((New-Object System.Net.WebClient).DownloadString('https://raw.githubusercontent.com/Fallion/dotfiles/master/windows/install.ps1'))`

For system settings
`Set-ExecutionPolicy Bypass -Scope Process -Force; iex ((New-Object System.Net.WebClient).DownloadString('https://raw.githubusercontent.com/Fallion/dotfiles/master/windows/windows.ps1'))`