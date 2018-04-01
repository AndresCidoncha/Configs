# SuperInstaller

I made this repo for my news installations in Ubuntu. With the `superinstaller.sh` script, I add the repositories, intall the programs and with the `copyconfigs.sh` script I copy my configurations.


## Usage

For use the script you must open a terminal and type:

`./superinstaller.sh`

You must fill `programs.json` with packages definitions. You can use programs-template.json as a base.

Additional options can be defined package definition:

* `pre_steps`: Commands to be executed before install the package.
* `repo`: Repository to be added to `sources.list`.
* `version`: If you wish to install a specific version.
* `additional_packages`: If you wanna install more than 1 package (for example, nemo package and his plugins).
* `post_steps`: Commands to be executed after install the package.


## Configs

#### Gnome Extensions

* Taskbar
* Drop Down Terminal
* Remove Arrows
* TopIcons
* Audio Switcher

### Scripts

* flog - Filter the syslog by a program name
* instalar - Quick installation and repo addition
* myip - Get the public ip (for others scripts)
* speedtest - Get the speed of the network (simplificed mode)
* crearepo - Create a remote repo in Github and initialize the local repo
