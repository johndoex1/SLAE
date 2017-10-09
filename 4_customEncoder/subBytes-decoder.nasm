; Content:	nasm file for decoding shellcode generated by subBytes-encoder.py
; Author: 	Florian Hansemann | @HanseSecure | https://hansesecure.de
; Date: 	09/2017
;
;
; For testing:
;	#1 insert evilShellcode into subBytes-encoder.py and run it
;	#2 note encodedShellcode, length and randomInt to this file
;	#3 compile -> objdump -> skeleton shellcode.c -> Bingo!
;


global _start			

section .text
_start:

	jmp short call_decoder		; first part of the classic jmp-call-pop method



decoder:
	pop esi				; pop Shellcode-Addess from the stack and save it into the esi register
	xor ecx, ecx			; cleanup ecx register
	mov cl, 43			; counter for loop	= encodedShellcode length


decode:
	add byte [esi], 0x02		; add the randomInt to single byte in esi register
	inc esi				; next byte in esi
	loop decode			; do until ecx 		= 0

	jmp short Shellcode		; if looped eded:	jump to Shellcode

call_decoder:
	call decoder			; functionCall to save address of Shellcode on the stack
	Shellcode: db 0xe9,0x15,0x2f,0xbe,0xae,0x02,0x2f,0xd9,0xb1,0x-1,0x57,0x2f,0xd0,0xb0,0x0b,0xcb,0x7e,0x2f,0xbe,0xae,0x-1,0x2f,0xd9,0xcb,0x7e,0xe6,0xe2,0xfd,0xfd,0xfd,0x46,0x63,0x6a,0x6a,0x6d,0x1e,0x55,0x6d,0x70,0x6a,0x62,0x1f,0x08


