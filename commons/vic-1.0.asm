/*
	author: padnest@gmail.com
	assembler: kick assembler 5.16

	changelog:
		- 1.0:
			- first release
*/
#importonce

.namespace Vic {

	.label SCREEN_ADDR = $0400
	.label COLOR_RAM_ADDR = $d800

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
		.label PosX = $d010
		.label Enabled = $d015
		.label DoubleHeight = $d017
		.label Priority = $d01b
		.label Multicolor = $d01c
		.label DoubleWidth = $d01d
		.label SpriteCollision = $d01e
		.label BackgroundCollision = $d01f

		.label SPRITE_0 = %00000001
		.label SPRITE_1 = %00000010
		.label SPRITE_2 = %00000100
		.label SPRITE_3 = %00001000
		.label SPRITE_4 = %00010000
		.label SPRITE_5 = %00100000
		.label SPRITE_6 = %01000000
		.label SPRITE_7 = %10000000
		.label SPRITE_ALL = $ff

		.label SPRITE_0_PTR = $3f8
		.label SPRITE_1_PTR = $3f9
		.label SPRITE_2_PTR = $3fa
		.label SPRITE_3_PTR = $3fb
		.label SPRITE_4_PTR = $3fc
		.label SPRITE_5_PTR = $3fd
		.label SPRITE_6_PTR = $3fe
		.label SPRITE_7_PTR = $3ff
	}

	Color: {
		.label Border = $d020
		.label Background0 = $d021
		.label Background1 = $d022
		.label Background2 = $d023
		.label Background3 = $d024
		.label Sprites1 = $d025
		.label Sprites2 = $d026

		.label COLOR_BLACK 	= 0
		.label COLOR_WHITE 	= 1
		.label COLOR_RED 	= 2
		.label COLOR_CYAN 	= 3
		.label COLOR_PURPLE = 4
		.label COLOR_GREEN 	= 5
		.label COLOR_BLUE	= 6
		.label COLOR_YELLOW = 7
		.label COLOR_ORANGE = 8
		.label COLOR_BROWN 	= 9
		.label COLOR_LT_RED = 10
		.label COLOR_DK_GREY = 11
		.label COLOR_MD_GREY = 12
		.label COLOR_LT_GREEN = 13
		.label COLOR_LT_BLUE = 14
		.label COLOR_LT_GRAY = 15
	}

	Screen:{
		.label Control1 = $d011
		.label RasterLine = $d012 
		.label Control2 = $d015

		.label CTRL1_VERTICAL_SCROLL_BITMASK 	= %11111000
		.label CTRL1_SCREEN_SETUP_BITMASK 		= %10000111

		.label CTRL1_SCREEN_HEIGTH_24 			= %00000000
		.label CTRL1_SCREEN_HEIGTH_25 			= %00001000
		.label CTRL1_SCREEN_DMA_OFF 			= %00000000
		.label CTRL1_SCREEN_DMA_ON	 			= %00010000
		.label CTRL1_SCREEN_MODE_TEXT 			= %00000000
		.label CTRL1_SCREEN_MODE_BITMAP			= %00100000
		.label CTRL1_EXT_BACKGROUND_OFF			= %00000000
		.label CTRL1_EXT_BACKGROUND_ON			= %01000000
	}

	Memory:{
		.label Setup = $d018

		// CHR_1000 and CHR_1800 in VIC bank #0 ($0000) and #2 ($4000) select Character ROM instead.
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

.macro Vic_AckInterrupts() {
	asl	Vic.Interrupts.Status
}

.macro Vic_ClearMSBRasterLine() {
	lda Vic.Screen.Control1
	and #$7f
	sta Vic.Screen.Control1
}

.macro Vic_EnableInterrupts(mask) {
	lda #mask
	sta Vic.Interrupts.Enabled
}

.macro Vic_SetLSBRasterLine(value) {
	lda #value
	sta Vic.Screen.RasterLine
}

.macro Vic_SetMSBRasterLine() {
	lda Vic.Screen.Control1
	ora #$80
	sta Vic.Screen.Control1
}

.macro Vic_SetSpriteDataAddr(screenAddr, spriteNum, addr) {
	lda #[addr/64]
	sta screenAddr + $3f8 + spriteNum
}

.macro Vic_SetSpritePosX(spriteNum, posX){
	lda #<posX
	sta Vic.Sprite0.PosX + spriteNum*2
	lda Vic.Sprites.PosX
	.if(posX > 255){
		ora #[pow(2, spriteNum)]
	}
	else{
		and #[255 - pow(2, spriteNum)] 
	}
	sta Vic.Sprites.PosX
}
.macro Vic_SetSpritePosY(spriteNum, posY){
	lda #<posY
	sta Vic.Sprite0.PosY + spriteNum*2
}
.macro Vic_SetSpriteColor(spriteNum, color){
	lda #color
	sta Vic.Sprite0.Color + spriteNum
}

.macro Vic_ScreenSetup(mask) {
	lda Vic.Screen.Control1
	and #Vic.Screen.CTRL1_SCREEN_SETUP_BITMASK
	ora #mask
	sta Vic.Screen.Control1
}

.macro Vic_WaitLSBRasterLine(line) {
	lda #line
	cmp Vic.Screen.RasterLine
	bne *-3
}
