/*
Program: DevBoard_x910CF.c
Date: 8/18/2014
Description: 
This is the power sequencing handling for the Plug in Evaluation board. The board takes in a couple of I/O
and then turns on/off the module, including the VBUS signal which is handled externally with a FET array. 

http://www.janus-rc.com/terminuscf.html

*/

//Main include
#include "DevBoard_x910CF.h"


/*
In AVR-GCC, a word is two bytes while a block is an arbitrary number of bytes which you supply (think string buffers). 

uint8_t eeprom_read_byte (const uint8_t *addr)
void eeprom_write_byte (uint8_t *addr, uint8_t value)
uint16_t eeprom_read_word (const uint16_t *addr)
void eeprom_write_word (uint16_t *addr, uint16_t value)
void eeprom_read_block (void *pointer_ram, const void *pointer_eeprom, size_t n)
void eeprom_write_block (void *pointer_eeprom, const void *pointer_ram, size_t n) 
*/

//Defining the CPU speed internally
//#define F_CPU (128000UL)
#define ON (true)
#define OFF (false)

//Defining the EEPROM address for the auto-on bit
//#define EEPADDR 0x46


/****************
Global Variables
****************/



int main(void)
{

	bool IsPWRMONOn = false; //Initialize to OFF
	bool AutoOn = false;	//Initialize to OFF
	bool IsVBUSOn = false; //Initialize to OFF
	uint8_t i = 0;



	Hardware_Init(); //Set I/O

	_delay_ms(10); //Delay 10mS to let I/O settle

	GSM_Reset(); //Hold the modem in reset upon startup.

	_delay_ms(10); //Delay 10mS to let I/O settle

	//We can enable the watchdog for up to 8 seconds on the ATTiny24 using the below function
	//wdt_enable(WDTO_8S);

	//Reset the watchdog timer.
	//wdt_reset(); 



	while (1)
	{

		//Reset the watchdog timer.
		//wdt_reset(); 

		//Check if we are running with Auto-On

		AutoOn = AutoOn_Task(); //boolean

		RS232_Task(); //Run the RS232 task to disable/enable the transceivers. This should happen every loop.

		
		if (AutoOn == false)
		{ //Auto on is not being used, read PWRMON and act accordingly. This mainly adjusts VBUS since RS232 task already handles the transceivers.
			
			IsPWRMONOn = Get_PWRMONStatus();

			//If PWRMON is read as being HIGH, we wait 7 seconds (5s ON/OFF possible hold + 2s boot up pause after ON/OFF release).
			//If it's already ON we don't touch it.
			if (IsPWRMONOn == true && IsVBUSOn == false)
			{
				_delay_ms(7000); //7s delay
				IsVBUSOn = USB_VBUS_CNTL(ON); //Turn VBUS on
				//wdt_reset(); //Reset the watchdog
			}

			//If PWRMON is read as being LOW, we turn VBUS off. If it's already OFF we don't touch it. 
			else if (IsPWRMONOn == false && IsVBUSOn == true)
			{
				IsVBUSOn = USB_VBUS_CNTL(OFF); //Turn VBUS off
			}


		} //If end

		else //Automatic turn on, check for PWRMON and act accordingly. Attempt turn on, if turn on is OK enable VBUS
		{

			IsPWRMONOn = Get_PWRMONStatus();

			while (IsPWRMONOn == false && i <= 4)
			{
				
				GSM_TurnON();

				_delay_ms(4000); //Wait for 4 seconds before reading again to give it time to properly start 
								 //(3 second turn on + 4 second delay = 7 seconds, matches above)

				//wdt_reset(); //Reset the watchdog, ON/OFF
				
				i++; //increment counter

				IsPWRMONOn = Get_PWRMONStatus(); //Update PWRMOn status
			} //If End

			if (IsPWRMONOn == false && i >= 4)
			{
				GSM_Reset(); //If we've tried at least 5 times and still no turn on, hit the reset signal for 1s to hardware reboot the modem. 
			}

			i = 0; //Reset counter if it passes or fails power on


			//If PWRMON is read as being HIGH, turn on VBUS. We've already waited 5s (3s turn on + 2s delay)
			//If it's already ON we don't touch it.
			if (IsPWRMONOn == true && IsVBUSOn == false)
			{
				IsVBUSOn = USB_VBUS_CNTL(ON); //Turn VBUS on
			}

			//If PWRMON is read as being LOW, we turn VBUS off. If it's already OFF we don't touch it. 
			else if (IsPWRMONOn == false && IsVBUSOn == true)
			{
				IsVBUSOn = USB_VBUS_CNTL(OFF); //Turn VBUS off
			}



		}//else end


	}//While End

  return 1;

}//Main End
