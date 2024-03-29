#include "Transistortester.h"
void Calibrate_UR(void) {
 // get reference voltage, calibrate VCC with external 2.5V and
 // get the port output resistance

#ifdef AUTO_CAL
  uint16_t sum_rm;	// sum of 3 Pin voltages with 680 Ohm load
  uint16_t sum_rp;	// sum of 3 Pin voltages with 680 Ohm load
  uint16_t u680;	// 3 * (Voltage at 680 Ohm)
#endif


  ADCconfig.U_AVCC = U_VCC;     // set initial VCC Voltage
  ADCconfig.Samples = R_ANZ_MESS;	// set number of ADC reads near to maximum
                                        //############################################
#if FLASHEND > 0x1fff
  uint16_t mv2500;
  ADC_PORT = TXD_VAL;                   // switch to 0V
  ADC_DDR = (1<<TPREF) | TXD_MSK;       // switch pin with 2.5V reference to GND
  wait20us();			// switch only short time, so that the relais do not really switch
  ADC_DDR =  TXD_MSK;		// switch pin with reference back to input
  mv2500 = W5msReadADC(TPREF); // read voltage of 2.5V precision reference
  if ((mv2500 > 2250) && (mv2500 < 2750)) {
     // precision voltage reference connected, update U_AVCC
     WithReference = 1;
     ADCconfig.U_AVCC = (unsigned long)((unsigned long)ADCconfig.U_AVCC * 2495) / mv2500;
  }
#endif
#ifdef WITH_AUTO_REF
  (void) ReadADC(MUX_INT_REF);	// read reference voltage 
  ref_mv = W5msReadADC(MUX_INT_REF);	// read reference voltage 
#else
  ref_mv = DEFAULT_BAND_GAP;    // set to default Reference Voltage
#endif
  RefVoltage();			//compute RHmultip = f(reference voltage)
                                        //############################################

#ifdef AUTO_CAL
  // measurement of internal resistance of the ADC port outputs switched to GND
  ADC_DDR = 1<<TP1 | TXD_MSK;	//ADC-Pin  1 to output 0V
  R_PORT = 1<<PIN_RL1;		//R_L-PORT 1 to VCC
  R_DDR = 1<<PIN_RL1;		//Pin 1 to output and over R_L to VCC
  sum_rm = W5msReadADC(TP1);

  ADC_DDR = 1<<TP2 | TXD_MSK;	//ADC-Pin 2 to output 0V
  R_PORT =  1<<PIN_RL2;		//R_L-PORT 2 to VCC
  R_DDR = 1<<PIN_RL2;		//Pin 2 to output and over R_L to VCC
  sum_rm += W5msReadADC(TP2);

  ADC_DDR = 1<<TP3 | TXD_MSK;	//ADC-Pin 3 to output 0V
  R_PORT =  1<<PIN_RL3;		//R_L-PORT 3 to VCC
  R_DDR = 1<<PIN_RL3;		//Pin 3 to output and over R_L to VCC
  sum_rm += W5msReadADC(TP3);	//add all three values

  // measurement of internal resistance of the ADC port output switched to VCC
  R_PORT = 0;			// R-Ports to GND
  ADC_PORT = 1<<TP1 | TXD_VAL;	//ADC-Port 1 to VCC
  ADC_DDR = 1<<TP1 | TXD_MSK;	//ADC-Pin  1 to output 0V
  R_DDR = 1<<PIN_RL1;		//Pin 1 to output and over R_L to GND
  sum_rp = ADCconfig.U_AVCC - W5msReadADC(TP1);
      
  ADC_PORT = 1<<TP2 | TXD_VAL;	//ADC-Port 2 to VCC
  ADC_DDR = 1<<TP2 | TXD_MSK;	//ADC-Pin  2 to output 0V
  R_DDR = 1<<PIN_RL2;		//Pin 2 to output and over R_L to GND
  sum_rp += ADCconfig.U_AVCC - W5msReadADC(TP2);

  ADC_PORT = 1<<TP3 | TXD_VAL;	//ADC-Port 3 to VCC
  ADC_DDR = 1<<TP3 | TXD_MSK;	//ADC-Pin  3 to output 0V
  R_DDR = 1<<PIN_RL3;		//Pin 3 to output and over R_L to GND
  sum_rp += ADCconfig.U_AVCC - W5msReadADC(TP3);

  u680 = ((ADCconfig.U_AVCC * 3) - sum_rm - sum_rp);	//three times the voltage at the 680 Ohm
  pin_rmi = (unsigned long)((unsigned long)sum_rm * (unsigned long)R_L_VAL) / (unsigned long)u680;
//  adcmv[2] = pin_rm;	// for last output in row 2
  pin_rpl = (unsigned long)((unsigned long)sum_rp * (unsigned long)R_L_VAL) / (unsigned long)u680;
  resis680pl = pin_rpl + R_L_VAL;
  resis680mi = pin_rmi + R_L_VAL;
#endif

  ADCconfig.Samples = ANZ_MESS;	// set to configured number of ADC samples
 } 
 
