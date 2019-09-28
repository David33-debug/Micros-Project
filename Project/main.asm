.cseg
.org 0x0000
jmp main
.org 0x0002
jmp check
.org 0x0020
jmp count

main:
clr r24
ldi r16, 0b00000011
out eimsk, r16
ldi r16, 0b00001101
sts eicra, r16
ldi r17,1
sts timsk0, r17
ldi r17,0b00000000
out tccr0a, r17
ldi r17,0b00000010
out tccr0b, r17
ldi r16,0b11011111
out ddrb,r16
ldi r16,0b00010000
out ddrd,r16
ldi r16,0b11110111
out ddrc, r16
jmp Modes

Modes:
in r25, pinb
sbrc r25, 5
jmp stay
jmp Gamestay


startTest:
clr r18
clr r19	
ldi r16, 0b00010000
out portd, r16
call delay
out portd, r19
sei
jmp sleeping

stay:
in r24, pinc
cpi r24, 0b00001000
breq startTest
jmp stay

Gamestay:
in r26, pinc
cpi r26, 0b00001000
breq play
jmp Gamestay

sleeping:
sleep
jmp sleeping

task:
cli
lsr r18
jmp display
ret

count:
	inc r18
reti

check:
	cpi r19,0
	brne task
	call setting
reti

setting:
clr r18
inc r19
ret

display:
out portb, r18
jmp Modes

delay:
ldi r21,100
delay1:
ldi r22,100
delay2:
ldi r23,50
delay3:
dec r23
brne delay3
dec r22
brne delay2
dec r21
brne delay1
ret

play:
ldi r30,9
out portb, r30
jmp Modes

