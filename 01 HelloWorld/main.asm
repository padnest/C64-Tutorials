/*
	author: padnest@gmail.com
	assembler: kick assembler 5.16
*/
/******************************************************************************	
	HelloWorld - main
	
	goals:
		- a classic 'hello world' program just to warm up!
*******************************************************************************/

BasicUpstart2(Start)

Start:{
	lda #0
    sta $D020
    sta $D021
	// kernal clear screen routine
	jsr $e544

	ldx #0	
!:	
	lda HelloMsg, x
	beq exit
	sta $0400, x
	inx
	bne !-
exit:
	rts
}

.encoding "screencode_upper"
HelloMsg:
.text "HELLO WORLD!"
.byte 0
