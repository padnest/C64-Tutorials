/*
	author: padnest@gmail.com
	assembler: kick assembler 5.16

	changelog:
		- 1.0:
			- first release
*/
#importonce

.namespace Cia1 {

	PortA:{
		.label Data = $dc00
		.label Direction = $dc02
	}
	
	PortB:{
		.label Data = $dc01
		.label Direction = $dc03
	}

	TimerA:{
		.label CountLSB = $dc04
		.label CountMSB = $dc05
		.label Control = $dc0e
	}

	TimerB:{
		.label CountLSB = $dc06
		.label CountMSB = $dc07
		.label Control = $dc0f
	}

	TimeOfDay:{
		.label ThentsOfSecond = $dc08
		.label Seconds = $dc09
		.label Minutes = $dc0a
		.label Hours = $dc0b
	}

	Serial:{
		.label Data = $dc0c
	}

	Interrupts:{
		.label Control = $dc0d

		.label TIMER_A 		= %00000001
		.label TIMER_B 		= %00000010
		.label TOD_ALARM 	= %00000100
		.label SERIAL_DATA	= %00001000
		.label MASTER		= %10000000

		.label DISABLE_ALL  = $7f;
	}
	
}

.namespace Cia2 {

	PortA:{
		.label Data = $dd00
		.label Direction = $dd02

		.label VIC_BANK_0000 = %00000011	// #0
		.label VIC_BANK_4000 = %00000010	// #1
		.label VIC_BANK_8000 = %00000001	// #2
		.label VIC_BANK_C000 = %00000000	// #3
		
	}
	
	PortB:{
		.label Data = $dd01
		.label Direction = $dd03
	}

	TimerA:{
		.label CountLSB = $dd04
		.label CountMSB = $dd05
		.label Control = $dd0e
	}

	TimerB:{
		.label CountLSB = $dd06
		.label CountMSB = $dd07
		.label Control = $dd0f
	}

	TimeOfDay:{
		.label ThentsOfSecond = $dc08
		.label Seconds = $dc09
		.label Minutes = $dc0a
		.label Hours = $dc0b
	}

	Serial:{
		.label Data = $dd0c
	}

	Interrupts:{
		.label Control = $dd0d

		.label TIMER_A 		= %00000001
		.label TIMER_B 		= %00000010
		.label TOD_ALARM 	= %00000100
		.label SERIAL_DATA	= %00001000
		.label MASTER		= %10000000

		.label DISABLE_ALL  = $7f;
	}

}


.namespace Cia {

	Joystick:{
		.label Port1 = Cia1.PortB.Data
		.label Port2 = Cia1.PortA.Data

		.label UP 		= %00000001
		.label DOWN 	= %00000010
		.label LEFT		= %00000100
		.label RIGHT	= %00001000
		.label FIRE		= %00010000
	}
}

.macro Cia_DisableAllInterrupts() {
	lda #$7f
	sta Cia1.Interrupts.Control
	sta Cia2.Interrupts.Control
}

.macro Cia_ReadJoystick(portNum) {
	.if(portNum==1){
		lda Cia.Port1
	}
	else{
		lda Cia.Port2
	}
}
