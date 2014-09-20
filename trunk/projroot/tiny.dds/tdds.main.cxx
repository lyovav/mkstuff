#include <LiquidCrystal_I2C.h>
#include <Arduino.h>
#include <afx/sleep.h>
#include <stdint.h>
#include <avr/interrupt.h>
#include <avr/io.h>
#include <avr/pgmspace.h>

I2C::LCD lcd(16, 2, 0x20, 2, 1, 0, 4, 5, 6, 7, 3, Generic::POSITIVE);

#define SAMPLE_RATE 8000 // 8 ksps

const uint8_t sinewave[256] PROGMEM =
{
	0x80,0x83,0x86,0x89,0x8c,0x8f,0x92,0x95,0x98,0x9c,0x9f,0xa2,0xa5,0xa8,0xab,0xae,
	0xb0,0xb3,0xb6,0xb9,0xbc,0xbf,0xc1,0xc4,0xc7,0xc9,0xcc,0xce,0xd1,0xd3,0xd5,0xd8,
	0xda,0xdc,0xde,0xe0,0xe2,0xe4,0xe6,0xe8,0xea,0xec,0xed,0xef,0xf0,0xf2,0xf3,0xf5,
	0xf6,0xf7,0xf8,0xf9,0xfa,0xfb,0xfc,0xfc,0xfd,0xfe,0xfe,0xff,0xff,0xff,0xff,0xff,
	0xff,0xff,0xff,0xff,0xff,0xff,0xfe,0xfe,0xfd,0xfc,0xfc,0xfb,0xfa,0xf9,0xf8,0xf7,
	0xf6,0xf5,0xf3,0xf2,0xf0,0xef,0xed,0xec,0xea,0xe8,0xe6,0xe4,0xe2,0xe0,0xde,0xdc,
	0xda,0xd8,0xd5,0xd3,0xd1,0xce,0xcc,0xc9,0xc7,0xc4,0xc1,0xbf,0xbc,0xb9,0xb6,0xb3,
	0xb0,0xae,0xab,0xa8,0xa5,0xa2,0x9f,0x9c,0x98,0x95,0x92,0x8f,0x8c,0x89,0x86,0x83,
	0x80,0x7c,0x79,0x76,0x73,0x70,0x6d,0x6a,0x67,0x63,0x60,0x5d,0x5a,0x57,0x54,0x51,
	0x4f,0x4c,0x49,0x46,0x43,0x40,0x3e,0x3b,0x38,0x36,0x33,0x31,0x2e,0x2c,0x2a,0x27,
	0x25,0x23,0x21,0x1f,0x1d,0x1b,0x19,0x17,0x15,0x13,0x12,0x10,0x0f,0x0d,0x0c,0x0a,
	0x09,0x08,0x07,0x06,0x05,0x04,0x03,0x03,0x02,0x01,0x01,0x00,0x00,0x00,0x00,0x00,
	0x00,0x00,0x00,0x00,0x00,0x00,0x01,0x01,0x02,0x03,0x03,0x04,0x05,0x06,0x07,0x08,
	0x09,0x0a,0x0c,0x0d,0x0f,0x10,0x12,0x13,0x15,0x17,0x19,0x1b,0x1d,0x1f,0x21,0x23,
	0x25,0x27,0x2a,0x2c,0x2e,0x31,0x33,0x36,0x38,0x3b,0x3e,0x40,0x43,0x46,0x49,0x4c,
	0x4f,0x51,0x54,0x57,0x5a,0x5d,0x60,0x63,0x67,0x6a,0x6d,0x70,0x73,0x76,0x79,0x7c
};

uint8_t i = 0;
int outputPin = 6; // (PCINT22/OC0A/AIN0)PD6, Arduino Digital Pin 6
ISR(TIMER1_COMPA_vect)
{
	//OCR0A = pgm_read_byte(&sinewave[i]);
	analogWrite(outputPin, pgm_read_byte(&sinewave[i]));
	i++;
}

void startPlayback()
{
	pinMode(outputPin, OUTPUT);
	// Set Timer 0 Fast PWM Mode (Section 14.7.3)
	// WGM = 0b011 = 3 (Table 14-8)
	// TOP = 0xFF, update OCR0A register at BOTTOM
	TCCR0A |= _BV(WGM01) | _BV(WGM00);
	TCCR0B &= ~_BV(WGM02);
	// Do non-inverting PWM on pin OC0A, arduino digital pin 6
	// COM0A = 0b10, clear OC0A pin on compare match,
	// set 0C0A pin at BOTTOM (Table 14-3)
	TCCR0A = (TCCR0A | _BV(COM0A1)) & ~_BV(COM0A0);
	// COM0B = 0b00, OC0B disconnected (Table 14-6)
	TCCR0A &= ~(_BV(COM0B1) | _BV(COM0B0));
	// No prescaler, CS = 0b001 (Table 14-9)
	TCCR0B = (TCCR0B & ~(_BV(CS02) | _BV(CS01))) | _BV(CS00);
	// Set initial pulse width to the first sample.
	OCR0A = pgm_read_byte(&sinewave[0]);
	// Set up Timer 1 to send a sample every interrupt.
	cli(); // disable interrupts
	// Set CTC mode (Section 15.9.2 Clear Timer on Compare Match)
	// WGM = 0b0100, TOP = OCR1A, Update 0CR1A Immediate (Table 15-4)
	// Have to set OCR1A *after*, otherwise it gets reset to 0!
	TCCR1B = (TCCR1B & ~_BV(WGM13)) | _BV(WGM12);
	TCCR1A = TCCR1A & ~(_BV(WGM11) | _BV(WGM10));
	// No prescaler, CS = 0b001 (Table 15-5)
	TCCR1B = (TCCR1B & ~(_BV(CS12) | _BV(CS11))) | _BV(CS10);
	// Set the compare register (OCR1A).
	// OCR1A is a 16-bit register, so we have to do this with
	// interrupts disabled to be safe.
	OCR1A = F_CPU / SAMPLE_RATE; // 16e6 / 8000 = 2000
	// Enable interrupt when TCNT1 == OCR1A (p.136)
	TIMSK1 |= _BV(OCIE1A);
	i = 0;
	sei(); // enable interrupts
}

extern "C" void Main()
{
	init();

	lcd.begin();

	lcd.setCursor(0, 0);
	lcd.print("    TINY DDS    ");
	lcd.setCursor(0, 1);
	lcd.print("  MNi  09.2014  ");

	analogWrite(A0, 0);

	sleep2s();

	lcd.clear();
	//lcd.print(pgm_read_byte(&sinewave_data[0]), 16);

	startPlayback();

	while (true)
		;
}
