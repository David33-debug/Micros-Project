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
ldi r16,0b11110000
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
clr r20
in r24, pinc
cpi r24, 0b00001000
breq startTest
jmp Modes

Gamestay:
ldi r28,1
ldi r20,1
ldi r29,0
in r26, pinc
cpi r26, 0b00001000
breq play
jmp Modes

sleeping:
sleep
jmp sleeping

task:
cli
lsr r18
cpi r20,1
breq gamePlay
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
ldi r27,0
out portd, r27
ldi r27, 0b00000111
in r24, tcnt0
and r27, r24
inc r27
out portb, r27 
call delay4S
jmp startTest
gamePlay:
out portb, r18
cp r27,r18
breq output2
cp r27,r18
brne output1


output1:
cpi r18,10
brsh output3
ldi r20,2
add r29,r20
ldi r18,0b01000000
out portd, r18
jmp Modes
output2:
subi r29,1
ldi r19, 0b10000000
out portd, r19
jmp Modes
output3:
ldi r19,0b00100000
out portd, r19
jmp Modes

delay4S:
push r16
push r17
push r18
push r19
loop1:
ldi r19, 100
loop2:
ldi r18,50
loop3:
ldi r17,65
loop4:
ldi r16, 65
loop5:
dec r16
brne loop5
dec r17
brne loop4
dec r18
brne loop3
dec r19
brne loop2
pop r19
pop r18
pop r17
pop r16
ret