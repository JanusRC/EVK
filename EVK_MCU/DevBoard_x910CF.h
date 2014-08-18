/*********************************************
File: DevBoard_x910CF.h
Description: 
This header file contains hardware defines and functions

*********************************************/

/*************
I/O Definitions

PA0: TR_INVALID signal monitor. Set as input with pull up disabled
	 Reads the Trace RS232 Invalid signal
	 Valid: Signal HIGH
	 Invalid: Signal LOW

PA1: AT_INVALID signal monitor. Set as input with with pull up disabled
	 Reads the AT Command RS232 Invalid signal
	 Valid: Signal HIGH
	 Invalid: Signal LOW

PA2: TR_EN. Set as an active drive output, initialize low. 
	 The signal is pulled down externally via 10k resistor.
	 This signal controls the RS232 Drivers for the Trace port.
	 Enable: Signal HIGH
	 Disable: Signal LOW
	 

PA3: AT_EN. Set as an active drive output, initialize low. 
	 The signal is pulled down externally via 10k resistor.
	 This signal controls the RS232 Drivers for the Trace port.
	 Enable: Signal HIGH
	 Disable: Signal LOW

PA4: ISP SCLK

PA5: ISP MISO

PA6: ISP MOSI/PWRMON. Set as input with pull up disabled.
	 Reads the PWRMON signal to detect if the modem is on.
	 Modem ON: Signal HIGH
	 Modem OFF: Signal LOW
	 

PA7: AUTO_ON_CNTL signal monitor. Set as input with pull up enabled.
	 Reads the control signal that tells the micro to turn the modem on.
	 This is a jumper that connects to ground.
	 automatically or not. 
	 Automatic ON: Signal HIGH
	 Manual control: Signal LOW (grounded)

PB0: ENABLE_VBUS. Set as input with pull up disabled.
	 This signal controls the FET that passes the 5V logic to the modem.
	 It's pulled up externally, so ground or Hi-Z only.
	 VBUS OFF: Signal Hi-Z
	 VBUS ON: Signal LOW

PB1: CELL Reset. This is used to hard reset the cellular modem.
	 Set as input with pull up disabled for open collector control
	 of the signal. 

PB2: CELL ON/OFF This is used to turn the cellular modem on or off.
	 Set as input with pull up disabled for open collector control
	 of the signal. 

PB3: RESET

*************/

/*************
Includes
*************/

//Avr includes
#include <avr/io.h>
#include <util/delay.h>		//Timer delays
#include <avr/wdt.h>		//Watchdog
#include <avr/power.h>
#include <avr/interrupt.h>
#include <string.h>			//Allows string
#include <stdbool.h>		//Allows boolean
//#include <avr/eeprom.h>		//EEPROM usage

//This needs to be defined here too, arbitrarily picked EEPROM address
//#define EEPADDR 0x46


//Mixed input/outputs, 1=input, 0=output (will be inverted during init)
#define INIT_DDRA_MASK			((1 << 0) | (1 << 1) | (0 << 2) | (0 << 3) | (1 << 4) | (1 << 5) | (1 << 6) | (1 << 7))
//Mixed pull up enable/disable, 1=disabled, 0=enabled
#define INIT_PORTA_MASK			((1 << 0) | (1 << 1) | (1 << 2) | (1 << 3) | (1 << 4) | (1 << 5) | (1 << 6) | (0 << 7))


//Mixed input/outputs, 1=input, 0=output (will be inverted during init)
#define INIT_DDRB_MASK			((0 << 0) | (1 << 1) | (1 << 2) | (1 << 3))
//Mixed pull up enable/disable, 1=disabled, 0=enabled
#define INIT_PORTB_MASK			((1 << 0) | (1 << 1) | (1 << 2) | (1 << 3))



#define PWRMON_Def	(1 << 6) //Define PWRMON for basic compare
#define AUTOON_Def	(1 << 7) //Define Auto-On for basic compare
#define TR_INV_Def	(1 << 0) //Define Trace invalid signal, 0 = invalid
#define AT_INV_Def	(1 << 1) //Define AT invalid signal, 0 = invalid



/*************
Variables
*************/
bool TraceFlag = false; //Initial Value
bool ATFlag = false; //Initial Value


static inline bool Get_PWRMONStatus(void)
{
	//Reads the status of powermon, does not have any arguments
	//Returns True if PWRMON is high, 
	//Returns False if PWRMON is low.

	char PMONCompare = (PINA & PWRMON_Def); // = x * 0b01000000, so only find PA6

	if (PMONCompare == PWRMON_Def) //Does it equal 1?
	{
		return true;
	}

	else
	{
		return false;
	}

}

static inline bool AutoOn_Task()
{
	//Reads the status of the Auto On control signal, if the signal is LOW (Jumper placed) then turn on the Auto-On function. If the signal
	//is HIGH, then Auto-On does not happen.
	//Returns TRUE if Auto-on is active.
	//Returns FALSE if not.

	//PA7: Auto On Toggle

	char AutoCompare = (PINA & AUTOON_Def); // = x * 0b10000000, so only find PA7

	if (AutoCompare == 0) //Does it equal 0
	{
		return true;
	}

	else
	{
		return false;
	}
}


static inline void RS232_Task(void)
{
	//Reads the status of the two RS232 invalid signals and enables the drivers accordingly.

	//Sets the TR_EN, AT_EN, or BOTH HIGH or LOW depending on what the invalid signals show.

	//PA0: TR_INV Signal
	//PA1: AT_INV Signal

	//PA2: TR_EN Signal, controlled as active drive. Set as output so control PORT
	//PA3: AT_EN Signal, controlled as active drive. Set as output so control PORT

	//The schematic is connecting in the way that the following logic should be true:
	//AT Valid = Both drivers enabled
	//Trace Valid = Trace driver enabled

	//The AT command RS232 signals utilize both transceivers, Trace only runs through it's own
	//IF's clear the drivers independently, if/else at the end enables with AT port taking priority.

	//Flag values are used/updated to remove the port's from being touched every pass


	char TraceCompare = (PINA & TR_INV_Def); // = x * 0b00000001, so only find PA0
	char ATCommandCompare = (PINA & AT_INV_Def); // = x * 0b00000010, so only find PA1

	if (ATCommandCompare == 0 && ATFlag == true) //AT Commands invalid, was valid
	{
		PORTA  &= ~(1<<3); //Set PA3 LOW
		ATFlag = false; //Update Value
	}

	if (TraceCompare == 0 && TraceFlag == true && ATFlag == false) //Trace invalid, was valid, AT no longer valid
	{
		PORTA  &= ~(1<<2); //Set PA2 LOW
		TraceFlag = false; //Update Value
	}

	if (ATCommandCompare == AT_INV_Def && ATFlag == false) //AT Commands are VALID, was invalid
	{
		PORTA  |= (1<<2); //Set PA2 HIGH
		PORTA  |= (1<<3); //Set PA3 HIGH
		ATFlag = true; //Drivers on
		TraceFlag = true; //Drivers on
	}

	else if (TraceCompare == TR_INV_Def && TraceFlag == false) //Trace ONLY VALID, was invalid
	{
		PORTA  |= (1<<2); //Set PA2 HIGH
		TraceFlag = true; //Drivers on
	}


}


static inline void GSM_TurnON(void)
{
	//Drops the ON/OFF line LOW for 4 seconds then releases to turn the module ON
	//PB2 PORT setting is already 0, so we only control the direction for OC control
	DDRB |= (1<<2); //Turn it into an Output, GND

	//2300ms = ~3s with delays : This was the old setting and gave just under 3s (2.8)
	//1000ms delays seem really accurate, so cascade 3 of them to get exact 3s
	_delay_ms(1000);	
	_delay_ms(1000);	
	_delay_ms(1000);

	DDRB &= ~(1<<2); //Turn it into an Input, Tristate

}

static inline void GSM_Reset(void)
{
	//Drops the RESET line LOW for 1 second then releases to reset the modem
	//PB2 PORT setting is already 0, so we only control the direction for OC control
	DDRB |= (1<<1); //Turn it into an Output, GND

	_delay_ms(1000);	//1s

	DDRB &= ~(1<<1); //Turn it into an Input, Tristate

}

static inline bool USB_VBUS_CNTL(bool VONOFF)
{
	//Controls the USB VBUS signal, depending on what is passed in.
	//PB0 PORT setting is output w/ default to LOW
	//Returns true if Vbus is turned ON
	//Returns false if Vbus is turned OFF
	//Returns false if there was an error

	if (VONOFF == true)
	{
		PORTB |= (1<<0); //I/O HIGH
		return true;
	}

	else if (VONOFF == false)
	{
		PORTB &= ~(1<<0); //I/O LOW
		return false;
	}


return false; //Default if there is an exception.	
}


static inline void Hardware_Init(void)
{

	/* Disable watchdog if enabled by bootloader/fuses */
	//MCUSR &= ~(1 << WDRF);
	//MCUSR = 0;		//Clear the watchdog reset flag, page 44 of the user manual.
	//wdt_disable();	//Disable the watchdog until we want it, required to clear the flag above before doing this


	/* Disable any clock division, 128Khz internal RC set by fuses */
	clock_prescale_set(clock_div_1);


	//Inputs with pull ups disabled for safety

	PORTA &= (0x00); //Clear PORTA
	DDRA  &= (0x00); //Clear DDRA

	PORTB &= (0x00); //Clear PORTB
	DDRB  &= (0x00); //Clear DDRB

	DDRA  |= ~(INIT_DDRA_MASK); //Set Port A I/O state
	PORTA |= ~(INIT_PORTA_MASK); //Set Port A pull up state

	DDRB  |= ~(INIT_DDRB_MASK); //Set Port B I/O state
	PORTB |= ~(INIT_PORTB_MASK); //Set Port B pull up state




}


