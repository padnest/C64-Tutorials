# Padnest's C64 development environment setup
 1. download and install [Sublime Text](https://www.sublimetext.com) (my version 3.2.2)   
 2. download and extract [Kick Assembler](http://theweb.dk/KickAssemble) (my version 5.16) to C:\C64\KickAssembler-5.16
 3. download and extract [Vice' C64 emulator](https://vice-emu.sourceforge.io/windows.html) (the recommended version is 3.1) to C:\C64\VICE-3.1
 4. download and extract [C64 65XE Debugger](https://sourceforge.net/projects/c64-debugger) (my version 0.64.58)  to C:\C64\65XE-Debugger-0.64.58
 5. setup 'Sublime Text'
	- Tools > Install Package Control	
	- Preferences > Package Control > Install package > search Kick Assembler
	- Preferences > Package Settings > SuBlimeKickAssemblerC64 > Preferences
		- add on User settings JSON (separated by comma):
			"kickass_jar_path": "C:/C64/KickAssembler-5.16/KickAss.jar"
			"kickass_run_path": "c:/C64/VICE-3.1/x64sc"
			"kickass_debug_path": "C:/C64/65XE-Debugger-0.64.58/C64Debugger"
6. create a workspace (ex: W:\C64\kickassembler) for projects
7. setup 'Vice'
	- run c:/C64/VICE-3.1/x64sc
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
8. setup Kick Assembler
	- backup file 'KickAss.cfg' as 'KickAss.cfg.bak'
	- edit file 'KickAss.cfg' adding
		-debugdump
9. default 'Sublime Text' shortkeys are:
	- Build and Run (F7)
	- Build and Debug (Shift+F7)
