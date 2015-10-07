/*********************************************
File: DevBoard_x910CF.h
Description: 
This header file contains hardware defines and functions

*********************************************/

/*************
I/O Definitions

PA0: PWRMON. Set as input with pull up disabled.
	 Reads the PWRMON signal as ADC2 input
	 Modem ON: Signal >= ~2v
	 Modem OFF: Signal <= ~2v

PA1: TR_EN Set as active drive output
	 Signal goes through an inverting buffer to the Transceiver.
	 Used as an RS232 enable override.
	 Enable: Signal LOW
	 Disable: Signal HIGH

PA2: AT_EN Set as active drive output
	 Signal goes through an inverting buffer to the Transceiver.
	 Used as an RS232 enable override.
	 Enable: Signal LOW
	 Disable: Signal HIGH
	 
PA3: 1V8_EN Set as an active drive output
	 Signal goes to a 1.8v regulator for the CODEC.
	 Enable: Signal HIGH
	 Disable: Signal LOW

PA4: ISP SCLK, User I/O

PA5: ISP MISO, User I/O

PA6: ISP MOSI, User I/O

PA7: AUTO_ON_CNTL signal monitor. Set as input with pull up enabled.
	 Reads the control signal that tells the micro to turn the modem on.
	 This is a jumper that connects to ground.
	 automatically or not. 
	 Automatic ON: Signal HIGH
	 Manual control: Signal LOW (grounded)

PB0: ENABLE_VBUS. 
 	 Set as output. Signal goes through an inverting buffer.
	 This signal controls the FET that passes the 5V logic to the modem.
	 VBUS OFF: Signal LOW
	 VBUS ON: Signal HIGH

PB1: CELL Reset. This is used to hard reset the cellular modem.
	 Set as output. Signal goes through an inverting buffer.
	 Modem OFF: Signal HIGH
	 Modem ON: Signal LOW

PB2: CELL ON/OFF This is used to turn the cellular modem on or off.
	 Set as output. Signal goes through an inverting buffer.
	 ON/OFF Low: Signal HIGH
	 ON/OFF High: Signal LOW

PB3: RESET

*************/

/************************************
Pin Mappings
************************************/

#define PWRMON_bm		(1 << 0)
#define TRANS_TR_EN_bm	(1 << 1)
#define TRANS_AT_EN_bm 	(1 << 2)
#define ENABLE_1V8_bm 	(1 << 3)
#define AUTO_ON_bm 		(1 << 7)
#define VBUS_EN_bm 		(1 << 0)
#define CELL_RESET_bm 	(1 << 1)
#define CELL_ONOFF_bm 	(1 << 2)

/************************************
Output Control Macros
************************************/

#define	TRANS_AT_ENABLE		{ PORTA &= ~TRANS_AT_EN_bm;	}	//Signal LOW  -> Buffer Drain HI-Z
#define	TRANS_AT_DISABLE	{ PORTA |=  TRANS_AT_EN_bm;	}	//Signal High -> Buffer Drain GND
#define	TRANS_TR_ENABLE		{ PORTA &= ~TRANS_TR_EN_bm;	}	//Signal LOW  -> Buffer Drain HI-Z
#define	TRANS_TR_DISABLE	{ PORTA |=  TRANS_TR_EN_bm;	}	//Signal High -> Buffer Drain GND

#define VBUS_DISABLE		{ PORTB &= ~VBUS_EN_bm;	}		//Signal LOW  -> Buffer Drain HI-Z -> FET OFF
#define VBUS_ENABLE			{ PORTB |=  VBUS_EN_bm;	}		//Signal High -> Buffer Drain GND -> FET ON

#define	V18_DISABLE			{ PORTA &= ~ENABLE_1V8_bm; } 	//Signal LOW
#define	V18_ENABLE			{ PORTA |=  ENABLE_1V8_bm; } 	//Signal High

#define CELL_RESET_HI		{ PORTB &= ~CELL_RESET_bm; }	//Signal LOW  -> Buffer Drain HI-Z
#define CELL_RESET_LO		{ PORTB |=  CELL_RESET_bm; }	//Signal High -> Buffer Drain GND

#define CELL_ONOFF_HI		{ PORTB &= ~CELL_ONOFF_bm; }	//Signal LOW  -> Buffer Drain HI-Z
#define CELL_ONOFF_LO		{ PORTB |=  CELL_ONOFF_bm; }	//Signal High -> Buffer Drain GND


/************************************
Includes
************************************/

//Avr includes
#include <util/delay.h>		//Timer delays
#include <avr/io.h>			//Port pins and various I/O defines
#include <avr/power.h>		//Runtime power and prescaler adjustments

//#include <stdbool.h>		//Allows boolean
//#include <avr/eeprom.h>	//EEPROM usage


/************************************
Variables & Defines
************************************/

//0   = 0V
//128 = 2.5v
//102 = ~2.0V
//255 = 5V
#define PWRMON_LEVEL 102

//Standard time for modem ON/OFF toggle
#define STD_ONOFF_TIME	3000

#define ON 	(1)
#define OFF (0)

#define POWERUP_TRIES 4


/************************************
Control Functions
************************************/

/******************
Discrete I/O Reads
******************/

//Reads the status of the Auto On signal, inverted
//Returns:
//0 = OFF
//1 = ON
uint8_t GetAutoOn(void)
{
	return (~PINA & AUTO_ON_bm);
}

//Read PWRMON signal
//VCC = 5V, PWRMON = ~2.8v when ON
uint8_t GetPWRMON(void)
{
	ADCSRA |= (1<<ADSC);			//Start ADC conversion
	while (!(ADCSRA & (1<<ADIF))); 	//Wait for conversion to finish
    
	ADCSRA |= (1<<ADIF); 			//Clear conversion complete flag

	//ADCH is now updated with a value 0-255
	if(ADCH < PWRMON_LEVEL)
	{
		//STAT_LED_OFF;
		return OFF;
	}
	else
	{
		//STAT_LED_ON;
		return ON;
	}
}

/******************
High Level Tasks
******************/

static void Modem_TurnON(int inTime)
{
	//Drops the ON/OFF line LOW for x seconds then releases to turn the module ON
	CELL_ONOFF_LO;

	//Delay based on input time
	_delay_ms(inTime);

	CELL_ONOFF_HI;

}

/*
static void Modem_TurnOFF(int inTime)
{
	//Drops the ON/OFF line LOW for x seconds then releases to turn the module ON

	CELL_ONOFF_LO;

	//Delay based on input time
	_delay_ms(inTime);

	CELL_ONOFF_HI;

}
*/

void Modem_Reset(void)
{
	//Drops the RESET line LOW for 1 second then releases to reset the modem

	CELL_RESET_LO;

	_delay_ms(1000);	//1s

	CELL_RESET_HI;

}

void DB9_Disable(void)
{
	TRANS_AT_DISABLE
	TRANS_TR_DISABLE
}

void DB9_Enable(void)
{
	TRANS_AT_ENABLE
	TRANS_TR_ENABLE
}

uint8_t Set_VBUS(uint8_t VONOFF)
{
	//Controls the USB VBUS signal, depending on what is passed in.
	//Returns 1 if Vbus is turned ON
	//Returns 0 if Vbus is turned OFF

	if (VONOFF)
	{
		VBUS_ENABLE;
		return ON;
	}

	else
	{
		VBUS_DISABLE;
		return OFF;
	}

}

/******************
HW Routines
******************/

/******************
ADC
******************/

//Initialize the ADC
void Init_ADC()
{
	//Not using free run mode to conserve power when necessary (no need to hammer the interface)

	//ADC MUX Register
	//REFS1 REFS0 MUX5 MUX4 MUX3 MUX2 MUX1 MUX0
	//			    0	 0	 0	  0	   0	0	ADC0
	//			    0	 0	 0	  0	   0	1	ADC1
	//			    0	 0	 0	  0	   1	0	ADC2
	//			    0	 0	 0	  0	   1	1	ADC3
	//			    0	 0	 0	  1	   0	0	ADC4
	//			    0	 0	 0	  1	   0	1	ADC5
	//			    0	 0	 0	  1	   1	0	ADC6
	//			    0	 0	 0	  1	   1	1	ADC7

	//REFS1 REFS0 Voltage Reference Selection
	//  0	  0	  VCC used as analog reference, disconnected from PA0 (AREF)
	//  0	  1	  External voltage reference at PA0 (AREF) pin, internal reference turned off
	//  1	  0	  Internal 1.1V voltage reference
	//  1	  1	  Reserved

	ADMUX = 0x00;						//Clear Register, Choose ADC channel 0

	//ADC Control and Status Register B
	//BIN ACME ADLAR ADTS2 ADTS1 ADTS0

	/****
	If ADATE in ADCSRA is written to one, the value of these bits selects which source will trigger
	an ADC conversion. If ADATE is cleared, the ADTS[2:0] settings will have no effect. A conversion
	will be triggered by the rising edge of the selected Interrupt Flag.
	****/
	
	//ADTS2 ADTS1 ADTS0 Trigger Source
	//  0	  0		0	Free Running mode

	ADCSRB = 0x00; 						//Clear Register
	ADCSRB |= (1 << ADLAR);				//Left Align, use ADCH for 0-255 reads

	//ADC Control and Status Register A
	//ADEN ADSC ADATE ADIF ADIE ADPS2 ADPS1 ADPS0

	//The ideal ADC clock speed is between 50 kHz and 200 kHz for the full 10 bits of resolution.
	//We're using 125Khz, divide by 2 to get 62.5khz
	//ADPS2 ADPS1 ADPS0 Division
	// 0	  0		0		2
	// 0	  0		1		2
	// 0	  1		0		4
	// 0	  1		1		8
	// 1	  0		0		16
	// 1	  0		1		32
	// 1	  1		0		64
	// 1	  1		1		128

	ADCSRA = 0x00; 						//Clear Register
	//ADCSRA |= (1 << ADATE);  				//Set Auto trigger enable (use free run)
	//ADCSRA |= ((1<<ADPS1)|(1<<ADPS0));	//Set Prescale = 128Khz, New prescale = 62.5khz
	ADCSRA |= (1<<ADEN);				//Power up the ADC
	//ADCSRA |= (1<<ADSC);				//Start ADC Conversions (for free run init)

}


static inline void Hardware_Init(void)
{

	/* Disable watchdog if enabled by bootloader/fuses */
	MCUSR &= ~(1 << WDRF);

	/* Set any clock division to 64 = 125Khz */
	clock_prescale_set(clock_div_64);

	//Initialize as inputs with pull ups disabled for safety & ease.
	PORTA &= (0x00); //Clear PORTA
	DDRA  &= (0x00); //Clear DDRA

	PORTB &= (0x00); //Clear PORTB
	DDRB  &= (0x00); //Clear DDRB

	//Set A Output I/O, others remain Input
	DDRA  |= (TRANS_TR_EN_bm | TRANS_AT_EN_bm);

	//Set A Required Initial Pull Ups, others remain LOW
	PORTA |= (AUTO_ON_bm);

	//All B Output
	DDRB  |= (VBUS_EN_bm | CELL_RESET_bm | CELL_ONOFF_bm);
	
	//All B Low

	//Ensure the modem is in reset at startup
	CELL_RESET_LO

	//Esnure the RS232 lines are disabled at startup
	DB9_Disable();

	//Esnure VBUS is disabled at startup
	VBUS_DISABLE

	//Esnure the 1.8v CODEC regulator is disabled at startup
	V18_DISABLE

	//Initialize ADC
	Init_ADC();


}


