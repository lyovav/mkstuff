/************************************************************************/
/* 14.08.2014 MNi: from original source Makefile for Atmega328P         */
/************************************************************************/
#ifndef _ESR_METER_CONFIG_328P_H__
#define _ESR_METER_CONFIG_328P_H__

#define INHIBIT_SLEEP_MODE 1

#ifndef F_CPU
#define F_CPU   8000000L
#endif

#define MHZ_CPU 8

#define WITH_MENU

// The menu function can be easier controlled with a incremental encoder (rotary switch).
// Both switches of the rotary switch can be connected with 1 kOhm resistors to PD2 and PD3.
// The common contact of the two switches must be connected to GND.
// You must also connect both switch contacts with two 10 kOhm resistors to VCC (pull up).
// The best choise is a incremental encoder with Push Button. The button can be connected
// parallel to the start key of the Transistor Tester.
// A define of the WITH_ROTARY_SWITCH enable the support for this extension.
// If your encoder has the same count of pulses at any switch as indexed positions (detent) for every turn,
// you should set the WITH_ROTARY_SWITCH to 2 or 3.
// If your encoder has twice the count of indexed positions, you should set the WITH_ROTARY_COUNT to 1.
// For rotary encoder without indexed position or with an indexed position at every change of
// the state of any switches (four times the count of pulses) you can set the
// WITH_ROTARY_COUNT to 5 for getting the best resolution.
// You can also use two separate push-buttons for Up and Down instead ot the rotary encoder.
// You must set the WITH_ROTARY_SWITCH to 4 for the UP/DOWN push-buttons.
//#define WITH_ROTARY_SWITCH=2
// the option CHANGE_ROTARY_DIRECTION changes the rotary direction by swap of switches
//#define CHANGE_ROTARY_DIRECTION

// Select your language:
// Available languages are: LANG_BRASIL, LANG_CZECH, LANG_DUTCH, LANG_ENGLISH, LANG_GERMAN, LANG_HUNGARIAN, LANG_ITALIAN,
//                          LANG_LITHUANIAN, LANG_POLISH, LANG_RUSSIAN , LANG_SLOVAK, LANG_SLOVENE, LANG_UKRAINIAN
#define UI_LANGUAGE LANG_RUSSIAN

// Can be used with a 4x20 character display for better using the additional space.
// Additional parameters, which are shown only short in row 2, will be shown in row 3 and 4 with this option.
//#define FOUR_LINE_LCD

// The LCD_CYRILLIC option is necessary, if you have a display with Cyrillic character-set.
// This lcd-display don't have a character for Ohm and for � (micro).
// Russian language requires a LCD controller with Russian character-set and option LCD_CYRILLIC!
//#define LCD_CYRILLIC

// The LCD_DOGM option must be set for support of the DOG-M type of LCD modules with ST7036 controller.
// For this LCD type the contrast must be set with software command.
//#define LCD_DOGM

// The LCD_ST7565 option must be set to support a 128x64 LCD graphics display
// with ST7565 controller. It is controlled with a 1-bit interface.
//WITH_LCD_ST7565 = 1

// If LCD_ST7565 option is used: Set the resitor ratio for the internal
// voltage regulator. Supported value range: 0..7.
// Good values are e.g. 4 or 7. If unsure just have a try.
#define LCD_ST7565_RESISTOR_RATIO 4

// If LCD_ST7565 option is used: Flip the display both on horizontal and
// vertical direction.
//#define WITH_LCD_ST7565_HV_FLIP 1

// If option WITH_LCD_ST7565 is present one of the following fonts should be
// chosen.
#define FONT_6X8
//#define FONT_8X8
//#define FONT_8X16

// Option STRIP_GRID_BOARD selects different board-layout, do not set for standard board!
// The connection of LCD is totally different for both versions.
//#define STRIP_GRID_BOARD

// The WITH_SELFTEST option enables self-test function (only for mega168 or mega328) including the calibration.
// Normally the mega168 uses self-test without T1 to T7 to enable both hFE measurements.
#define WITH_SELFTEST
// You can enable the extended tests T1 to T7 for the atmega168 by selecting the  NO_COMMON_COLLECTOR_HFE  option.
// The T1 to T7 tests are useful to find problems with your tester.
//#define NO_COMMON_COLLECTOR_HFE
//#define NO_COMMON_EMITTER_HFE
// You can also disable the extended tests T1 to T7 with the option NO_TEST_T1_T7 to accelerate the calibration
// for the atmega328 and atmega168.
//#define NO_TEST_T1_T7

// AUTO_CAL will enable the auto-calibration of zero offset of capacity measurement and
// also the port output resistance values will be find out in SELFTEST section.
// With a external capacitor a additionally correction of reference voltage is figured out for 
// low capacity measurement and also for the AUTOSCALE_ADC measurement.
// The AUTO_CAL option is only selectable for mega168 and mega328.
#define AUTO_CAL

// FREQUENCY_50HZ enables a 50 Hz frequency generator for up to one minute at the end of self-tests.
//#define FREQUENCY_50HZ

// The WITH_AUTO_REF option enables reading of internal REF-voltage to get factors for the Capacity measuring.
#define WITH_AUTO_REF
// REF_C_KORR corrects the reference Voltage for capacity measurement (<40uF) and has mV units.
// Greater values gives lower capacity results.
#define REF_C_KORR 12
// REF_L_KORR corrects the reference Voltage for inductance measurement and has mV units.
#define REF_L_KORR 40
// C_H_KORR defines a correction of 0.1% units for big capacitor measurement.
// Positive values will reduce measurement results.
#define C_H_KORR 0

// The WITH_UART option enables the software UART  (TTL level output at Pin PC3, 26).
// If the option is deselected, PC3 can be used as external voltage input with a
// 10:1 resistor divider.
#define WITH_UART 0

// With option TQFP_ADC6 or/and TQFP_ADC7 you can use the additional pins of the TQFP or
// the QFN package for external analog input. You should install a 10:1 voltage dividers
// on the selected pin(s).
// If both pins are defined, both voltages are measured with the voltage measure function.
// But for zener diode measurement the ADC6 pin is used, if both pins are defined.
//#define TQFP_ADC6

// For ATmega8/168/328 processor the option WITH_VEXT can only be set, if the PC3 pin
// is not used for serial output (WITH_UART option).
// For ATmega644/1284 processor the UART has a separate pin.  Therefore the external input
// at pin ADC3 can be enabled separate by setting the WITH_UART option.
//#define WITH_VEXT 1

// The CAP_EMPTY_LEVEL  defines the empty voltage level for capacitors in mV.
// Choose a higher value, if your Tester reports "Cell!" by unloading capacitors.
#define CAP_EMPTY_LEVEL 4

// The AUTOSCALE_ADC option enables the auto-scale ADC (ADC use VCC and Bandgap Ref).
#define AUTOSCALE_ADC
#define REF_R_KORR 3

// The ESR_ZERO value define the zero value of ESR measurement (units = 0.01 Ohm).
//#define ESR_ZERO 29
#define ESR_ZERO 20

// NO_AREF_CAP tells your Software, that you have no Capacitor installed at pin AREF (21).
// This enables a shorter wait-time for AUTOSCALE_ADC function.
// A capacitor with 1nF can be used with the option NO_AREF_CAP set.
#define NO_AREF_CAP

// The OP_MHZ option tells the software the Operating Frequency of your ATmega.
#define OP_MHZ 8

// Restart from sleep mode will be delayed for 16384 clock tics with crystal mode.
// Operation with the internal RC-Generator or external clock will delay the restart by only 6 clock tics.
// You must specify this with "#define RESTART_DELAY_TICS=6", if you don't use the crystal mode.
//#define RESTART_DELAY_TICS=6

// The USE_EEPROM option specify where you wish to locate fix text and tables.
// If USE_EEPROM is unset, program memory (flash) is taken for fix text and tables.
#define USE_EEPROM

// Setting EBC_STYPE will select the old style to present the order of Transistor connection (EBC=...).
// Omitting the option will select the 123=... style.  Every point is replaced by a character identifying 
// type of connected transistor pin (B=Base, E=Emitter, C=Collector, G=Gate, S=Source, D=Drain).
// If you select EBC_STYLE=321 , the style will be 321=... , the inverted order to the 123=... style.
//#define EBC_STYLE
//#define EBC_STYLE=321

// Setting of NO_NANO avoids the use of n as prefix for Farad (nF), the mikro prefix is used insted (uF).
// #define NO_NANO

// The PULLUP_DISABLE option disable the pull-up Resistors of IO-Ports.
// To use this option a external pull-up Resistor (10k to 30k)
// from Pin 13 to VCC must be installed!
#define PULLUP_DISABLE

// The ANZ_MESS option specifies, how often an ADC value is read and accumulated.
// Possible values of ANZ_MESS are 5 to 200 .
#define ANZ_MESS 25


// The POWER_OFF option enables the power off function, otherwise loop measurements infinitely
// until power is disconnected with a ON/OFF switch (#define POWER_OFF).
// If you have the tester without the power off transistors, you can deselect POWER_OFF .
// If you have NOT selected the POWER_OFF option with the transistors installed,
// you can stop measuring by holding the key several seconds after a result is
// displayed. After releasing the key, the tester will be shut off by timeout.
// Otherwise you can also specify, after how many measurements without found part
// the tester will shut down (#define POWER_OFF=5).
// The tester will also shut down with found part,
// but successfully measurements are allowed double of the specified number.
//  You can specify up to 255 empty measurements (#define POWER_OFF=255).
//#define POWER_OFF=5
//#define POWER_OFF 10

// Option BAT_CHECK enables the Battery Voltage Check, otherwise the SW Version is displayed instead of Bat.
// BAT_CHECK should be set for battery powered tester version.
//#define BAT_CHECK

// The BAT_OUT option enables Battery Voltage Output on LCD (if BAT_CHECK is selected).
// If your 9V supply has a diode installed, use the BAT_OUT=600 form to specify the
// threshold voltage of your diode to adjust the output value.
// This threshold level is added to LCD-output and does not affect the voltage checking levels.
#define BAT_OUT 150

// To adjust the warning-level and poor-level of battery check to the capability of a
// low drop voltage regulator, you can specify the Option BAT_POOR=5400 .
// The unit for this option value is 1mV , 5400 means a poor level of 5.4V.
// The warning level is 0.8V higher than the specified poor level (>5.3V).
// The warning level is 0.4V higher than the specified poor level (>2.9V, <=5.3V).
// The warning level is 0.2V higher than the specified poor level (>1.3V, <=2.9V).
// The warning level is 0.1V higher than the specified poor level (<=1.3V).
// Setting the poor level to low values is not recommended for rechargeable Batteries,
// because this increase the danger for deep discharge!!
#define BAT_POOR 6400

// Voltage divider for battery voltage measurement  10k / 3.3k = 133/33
//#define BAT_NUMERATOR=133
//#define BAT_DENOMINATOR=33
// Voltage divider for the external zener voltage measurement 180k / 20k = 10/1
//#define EXT_NUMERATOR=10
//#define EXT_DENOMINATOR=1

#endif // _ESR_METER_CONFIG_328P_H__
