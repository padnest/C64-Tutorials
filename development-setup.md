# Padnest's C64 development environment setup
 1. download and install [Sublime Text](https://www.sublimetext.com) (my version 3.2.2)   
 2. download and extract [Kick Assembler](http://theweb.dk/KickAssemble) (my version 5.16) to C:\C64\KickAssembler-5.16
 3. download and extract [Vice C64 emulator](https://vice-emu.sourceforge.io/windows.html) (the recommended version is 3.1) to C:\C64\VICE-3.1
 4. download and extract [C64 65XE Debugger](https://sourceforge.net/projects/c64-debugger) (my version 0.64.58)  to C:\C64\65XE-Debugger-0.64.58
 5. download and install [HxD editor](https://mh-nexus.de/en/downloads.php?product=HxD20) (my version 2.4.0.0 installable edition)
 6. setup 'Sublime Text'
	- Tools > Install Package Control	
	- Preferences > Package Control > Install package > search and install 'Kick Assembler'
	- Preferences > Package Control > Install package > search and install 'All Autocomplete'
	- Preferences > Package Settings > SuBlimeKickAssemblerC64 > Preferences
		- add on User settings JSON (separated by comma):
			"kickass_jar_path": "C:/C64/KickAssembler-5.16/KickAss.jar"
			"kickass_run_path": "C:/C64/VICE-3.1/x64sc"
			"kickass_debug_path": "C:/C64/65XE-Debugger-0.64.58/C64Debugger"
7. create a workspace (ex: W:\C64\kickassembler) for projects
8. setup 'Vice'
	- run C:/C64/VICE-3.1/x64sc
	- Menu > Settings
		- check 'Save settings on exit'
		- uncheck 'Confirm on exit'
		- on 'Autostart settings'
			- select 'Inject to RAM' on 'PRG autostart mode'
		- on 'Video settings' > 'Render filter' select 'None'
		- on 'VIC-II settings':
			- on 'Border mode' select 'Debug borders'
			- on 'VIC-II model' select '6569 (PAL)'
			- check VSP bug
9. setup Kick Assembler
	- backup file 'KickAss.cfg' as 'KickAss.cfg.bak'
	- edit file 'KickAss.cfg' adding
		-debugdump
10. default 'Sublime Text' shortkeys are:
	- Build and Run (F7)
	- Build and Debug (Shift+F7)
