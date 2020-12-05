BasicUpstart2(start)

start:
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

HelloMsg:
.encoding "screencode_upper"
.text "HELLO WORLD!"
.byte 0
