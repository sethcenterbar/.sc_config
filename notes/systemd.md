# systemd

## Dictionary
*systemd* --> an init system that manages how you start, stop services
*units* --> systemd calls daemons units

## URLS
https://wiki.archlinux.org/index.php/systemd#Basic_systemctl_usage
https://wiki.archlinux.org/index.php/Systemd/Timers
https://www.youtube.com/watch?v=Ej5DqUiSKSM

## General Notes
$ systemctl list-units --> displays services, slices, sockets, etc on current machine
$ systemctl list-units -t {target, service, timer, etc} --> specify the type of units to list
$ systemctl status mongod(.service is assumed) --> Shows if a unit is running and enabled.
$ systemctl start mongod --> starts the mongod daemon
$ systemctl stop mongod --> stops the mongod daemon
$ systemctl enable mongod --> makes the mongod daemon start at boot
$ systemctl disable  mongod --> stops the mongod daemon from starting at boot
$ systemctl restart  mongod --> restarts the mongod daemon 
	- Enabled And Disabled determines whether a unit starts at boot
$ systemctl --failed --> lists the units that failed to start up at boot
$ systemctl is-enabled mongod --> returns whether or not the mongod unit is enabled
	- 
$ systemctl reboot
$ systemctl reboot -->
$ systemctl suspend --> suspend the machine to ram

## Unit Files
$ systemctl show --property=UnitPath --> list locations from which unit files are loaded
/usr/lib/systemd/system/ --> unites provided by installed packages (do not edit these files)
/etc/systemd/system/ --> units installed by the system administrator (take precedence over those in /usr)
	- Comments prepended with # may be used in unit-files as well, but only in new lines. Do not use end-line comments after systemd parameters or the unit will fail to activate.
/run/systemd/system --> runtime unit files
$ systemctl list-unit-files --> view all unit files on a system
$ systemctl cat something.unit --> cats the unit file for a given unit
/etc/systemd/system --> expected location for customized unit file.
systemctl edit <unit> --> allows you to add customizations to a unit file. (adds to etc, then uses default confs for confs not added here, aka creatinga  'drop in' file)
systemctl edit --full <unit> --> adds a unit file to etc that is used instead of the usr version.

## Target Units	
	- A target is a  unit that syncs up other units when the computer boots or changes states.
	- Often used to bring the system to a new state. 
		- state with just a command line : multi-user.target
		- state with a desktop environment : graphical.target
	- Other units associate themselves with a target for an operating environment.
	- Common Targets
		- multi-user.target --> multi user system, like the old runlevel 3
		- graphical.target --> multi-user system with a desktop environment, similar to what runlevel 5 provided
		- rescue.target --> pulls in a basic systemd and file system mounts and provides a rescue shell
		- basic.target --> basic system, used during the boot process before another target takes over. 
		- sysinit.target --> system initializtion 
		- man 5 systemd.target --> defines the target unit configuration
		- man 7 systemd.special --> listing of all target units and definitions
$ systemctl cat graphical.target --> shows the unit file for the graphical target.
	
## Service Units
$ man 5 systemd.service --> more info about services


## JournalCtl
$ journalctl --> shows everything in the log
$ journalctl -b --> shows log output from most recent system boot
$ journalctl -u mongod --> shows logs for a specified unit mongod

## Timers
	- Timers are like cron schedules for systemd services
	- For each .timer file a matching .service file exists
		- eg. foo.timer and foo.service
		- timer file activates service file
		- to use a timer with a different name than the service, use Unit= in the [Unit] section
$ systemctl list-timers --all --> show all of the timers on the system
$ man 5 systemd.timer --> info about timers
$ man 7 systemd.time --> info about timers
``` example timer
[Unit]
Description=Run S3 daily backup

[Timer]
OnCalendar=Daily

[Install]
WantedBy=timers.target
```

