#include "avr-lcd-1602.h"

.global lcdspace
.global lcdnum
.global lcdchar
.global lcdcmd
.global lcdclear
.global lcdinit
.global lcdtext
.global lcdptext
.global lcdftext
.global lcdcchar
.global lcdclearline
.global lcd1
.global lcd2


.section .text

lcdspace:		ldi			r24, 0xef		; 0x20 - 0x31 + '1' = ' '
lcdnum:			subi		r24, -'1'		; 0xcf
lcdchar:		push		r17
 				mov			r17, r24
 				ldi			r24, 0x01
        		rjmp		lcd_pulse

lcdcmd:			push		r17
 				mov			r17, r24
 				ldi			r24, 0x00
lcd_pulse:		mov			r22, r17
 				rcall		_lcd_pulse
 				rcall		wait50us
c_putc_ret:		pop			r17
	 			ret

lcdclear:		ldi			r24, 0x01
 				rcall		lcdcmd
				rcall		wait10ms
 				ldi			r24, 0x80
 				rcall		lcdcmd
 				ret

lcdinit:		rcall		wait30ms
 				ldi			r24, 0x80
 				ldi			r22, 0x30
 				rcall		_lcd_pulse
				rcall		wait5ms
 				ldi			r24, 0x80
 				ldi			r22, 0x30
 				rcall		_lcd_pulse
 				rcall		wait1ms
 				ldi			r24, 0x80
 				ldi			r22, 0x30
 				rcall		_lcd_pulse
 				rcall		wait1ms
 				ldi			r24, 0x80
 				ldi			r22, 0x20		; switch to 4 Bit mode
 				rcall		_lcd_pulse
				rcall		wait10ms
				rcall		wait5ms
				ldi			r24, (LCDM_SetDisplayAndCursor | 0x04) ; Display on / Cursor off / no Blinking
				rcall		lcdcmd
 				ret

lcdtext:		push		r14
			 	push		r15
			 	push		r28
			 	push		r29
			 	mov			r14, r24
			 	movw		r28, r14
			 	movw		r14, r28
			 	mov			r15, r25
			 	movw		r28, r14
			 	rjmp		ad352
ad34e:			rcall		lcdchar
ad352:		 	ld			r24, Y+
			 	and			r24, r24
			 	brne		ad34e
			 	pop			r29
			 	pop			r28
			 	pop			r15
			 	pop			r14
			 	ret

lcdptext:		push		r28
			 	push		r29
			 	movw		r28, r24
str_loop:		movw		r30, r28
			 	lpm			r24, Z+
			 	and			r24, r24
			 	breq		str_end
			 	cpi			r24, 0x80
			 	breq		str_end
			 	rcall		lcdchar
			 	adiw		r28, 0x01
			 	rjmp		str_loop
str_end:	 	pop			r29
			 	pop			r28
			 	ret

lcdftext:	 	push		r28
			 	push		r29
			 	movw		r28, r24
fix_loop:		movw		r30, r28
				lpm			r24, Z+
			 	and			r24, r24
			 	breq		fix_end
			 	cpi			r24, 0x80
			 	breq		fix_end
			 	rcall		lcdchar
			 	adiw		r28, 0x01
			 	rjmp		fix_loop
fix_end:	 	pop			r29
			 	pop			r28
			 	ret

lcdcchar:	 	push		r16
			 	push		r17
			 	push		r28
			 	push		r29
			 	movw		r16, r24
			 	ldi			r28, 0x00
			 	ldi			r29, 0x00
ad3b2:			movw		r30, r16
				add			r30, r28
				adc			r31, r29
				lpm			r24, Z+
			 	rcall		lcdchar
			 	adiw		r28, 0x01
			 	cpi			r28, 0x08
			 	cpc			r29, r1
			 	brne		ad3b2
			 	pop			r29
			 	pop			r28
			 	pop			r17
			 	pop			r16
			 	ret

lcdclearline: 	push		r17
			 	ldi			r17, 0x14
clr_lop:	 	rcall		lcdspace
			 	subi		r17, 1
			 	brne		clr_lop
			 	pop			r17
			 	ret

lcd1:	 		ldi			r24, 0x80
			 	rcall		lcdcmd
			 	ret

lcd2:			ldi			r24, 0xc0
			 	rcall		lcdcmd
			 	ret
