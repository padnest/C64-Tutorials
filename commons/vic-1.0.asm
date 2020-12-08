/*
	author: padnest@gmail.com
	assembler: kick assembler 5.16

	changelog:
		- 1.0:
			- first release
*/
.namespace Vic {

	.label SCREEN_START = $0400

	Sprite0: {
		.label PosX = $d000
		.label PosY = $d001
		.label Color = $d027
	}

	Sprite1: {
		.label PosX = $d000
		.label PosY = $d001
		.label Color = $d028
	}

	Sprite2: {
		.label PosX = $d002
		.label PosY = $d003
		.label Color = $d029
	}

	Sprite3: {
		.label PosX = $d004
		.label PosY = $d005
		.label Color = $d02a
	}

	Sprite4: {
		.label PosX = $d006
		.label PosY = $d007
		.label Color = $d02b
	}

	Sprite5: {
		.label PosX = $d008
		.label PosY = $d009
		.label Color = $d02c
	}

	Sprite6: {
		.label PosX = $d00a
		.label PosY = $d00b
		.label Color = $d02d
	}

	Sprite7: {
		.label PosX = $d000
		.label PosY = $d001
		.label Color = $d02e
	}

	Sprites: {
		.label Enabled = $d015
		.label DoubleHeight = $d017
		.label Priority = $d01b
		.label Multicolor = $d01c
		.label DoubleWidth = $d01d
		.label SpriteCollision = $d01e
		.label BackgroundCollision = $d01f
	}

	Color: {
		.label Border = $d020
		.label Background0 = $d021
		.label Background1 = $d022
		.label Background2 = $d023
		.label Background3 = $d024
		.label Sprites1 = $d025
		.label Sprites2 = $d026
	}

	Screen:{
		.label Control1 = $d011
		.label RasterLine = $d012 
		.label Control2 = $d015
	}

	Memory:{
		.label Setup = $d018
		.label CHR_0000 = %00000000
		.label CHR_0800 = %00000010
		.label CHR_1000 = %00000100
		.label CHR_1800 = %00000110
		.label CHR_2000 = %00001000
		.label CHR_2800 = %00001010
		.label CHR_3000 = %00001100
		.label CHR_3800 = %00001110

		.label SCR_0000 = %00000000
		.label SCR_0400 = %00010000
		.label SCR_0800 = %00100000
		.label SCR_0C00 = %00110000	
		.label SCR_1000 = %01000000
		.label SCR_1400 = %01010000
		.label SCR_1800 = %01100000
		.label SCR_1C00 = %01110000
		.label SCR_2000 = %10000000
		.label SCR_2400 = %10010000
		.label SCR_2800 = %10100000
		.label SCR_2C00 = %10110000
		.label SCR_3000 = %11000000
		.label SCR_3400 = %11010000
		.label SCR_3800 = %11100000
		.label SCR_3C00 = %11110000
	}

	Interrupts:{
		.label Status = $d019
		.label Enabled = $d01a

		.label RASTER_LINE 			= %00000001
		.label SPRITE_BG_COLL 		= %00000010
		.label SPRITE_SPRITE_COLL 	= %00000100
		.label LP 					= %00001000
		.label ACK					= %10000000
	}

	// doesn't works outside Vic.ClearMSBRasterLine() = syntax error (it should be?)
	.macro ClearMSBRasterLine() {
		lda Screen.RasterLine
		and #$7f
		sta Screen.RasterLine
	}

	.macro SetMSBRasterLine() {
		lda Screen.RasterLine
		ora #$80
		sta Screen.RasterLine
	}
}

.macro ClearMSBRasterLine() {
	lda Vic.Screen.RasterLine
	and #$7f
	sta Vic.Screen.RasterLine
}

.macro SetMSBRasterLine() {
	lda Vic.Screen.RasterLine
	ora #$80
	sta Vic.Screen.RasterLine
}

.macro SetVicInterrupts(value) {
	lda value
	sta Vic.Interrupts.Enabled
}