/*
	author: padnest@gmail.com
	assembler: kick assembler 5.16

	changelog:
		- 1.0:
			- first release
*/
#importonce

.namespace Cpu {

	Memory:{
		.label Config = $0001

		// I/O area $D000-$DF00 is always enabled (bit #2 = 1)
		.label ALL_RAM 						= %00000100
		.label BANK_OUT_BASIC_AND_KERNAL 	= %00000101
		.label BANK_OUT_BASIC 				= %00000110
		.label BASIC_AND_KERNAL				= %00000111

		.label BITMASK 						= %11111000
	}

}

.macro Cpu_ConfigMemory(mask){
	lda Cpu.Memory.Config
	and #Cpu.Memory.BITMASK
	ora #mask
	sta Cpu.Memory.Config
}

.macro Cpu_RestoreAllRegisters(){
	pla
	tay
	pla
	tax
	pla
}

.macro Cpu_SaveAllRegisters(){
	pha
	txa
	pha
	tya
	pha
}

.macro Cpu_SetIRQVectors(addr) {
	lda #<addr
	sta $fffe			// low byte
	lda #>addr
	sta $ffff 			// high byte
}


