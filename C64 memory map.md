# C64 memory map
| Address         | Content		                  | Notes                       |
|-----------------|-----------------------------|-----------------------------|
|**$0000 - $00FF**|zero page RAM         		    |reserved to CPU|
|**$0100 - $01FF**|processor stack RAM  		    |reserved to CPU|
|**$0200 - $9FFF**|RAM							            ||
|**$A000 - $BFFF**|Basic ROM    				        |CPU writes to RAM (*); VIC reads from RAM|
|**$C000 - $CFFF**|RAM							            ||
|**$D000 - $DFFF**|I/O (VIC, SID, CIAs)         |VIC reads from RAM (**)|
|**$E000 - $FFFF**|Kernal ROM  					        |CPU writes to RAM (*); VIC reads from RAM|

(*) CPU must bank it out to read from the underneath RAM
(**) CPU must bank it out to write/read the underneath RAM; VIC reads always from the underneath RAM

## CPU reserved addresses
| Address         | Content	 	                    | Notes                          |
|-----------------|-------------------------------|--------------------------------|
|**$0000 - $0001**|special 6510 port        	    |RAM bank out + datasette control|
|**$0002 - $00FF**|zero page        				      ||
|**$0100 - $01FF**|stack            				      ||
|**$FFFA - $FFFB**|NMI service routine address    |LO - HI 16 bit address| 
|**$FFFC - $FFFD**|RESET service routine address  |LO - HI 16 bit address|
|**$FFFE - $FFFF**|IRQ service routine address 	  |LO - HI 16 bit address|

## CPU bank out control (address $01, bits 0-2)
| Value   | Result  		              |
|---------|---------------------------|
|**000**  |all RAM 					  |
|**x01**  |Basic and Kernal ROM are not visible: RAM at $A000 - $BFFF and $E000 - $FFFF|
|**x10**  |Basic ROM is not visible: RAM at $A000 - $BFFF |
|**x11**  |Basic and Kernal ROM at $A000 - $BFFF and $E000 - $FFFF|
|**0xx**  |Character ROM is visible at $D000 - $DFFF (except for the value 000)|
|**1xx**  |I/O area is visible at $D000 - $DFFF (except for the value 100)|
