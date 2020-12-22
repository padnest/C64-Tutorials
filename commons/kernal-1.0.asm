/*
	author: padnest@gmail.com
	assembler: kick assembler 5.16

	changelog:
		- 1.0:
			- first release
*/
#importonce

.namespace Kernal {

	.label CLEAR_SCREEN = $e544
	

}

.macro Kernal_ClearScreen() {
	jsr Kernal.CLEAR_SCREEN
}

