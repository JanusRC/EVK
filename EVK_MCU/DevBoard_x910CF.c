/*
Program:
Date: 
Description: 

*/

//Main include
#include "DevBoard_x910CF.h"


/****************
Global Variables
****************/


int main(void)
{

	uint8_t PWRMONStatus = OFF; 	//PWRMON status, initialize to OFF
	uint8_t VBUSStatus = OFF; 		//VBUS status, initialize to OFF
	uint8_t	AutoOn = OFF;			//Auto On signal, initialize to OFF
	uint8_t i = 0;					//General Counter, initialize to 0
	
	//Initialize the hardware on bootup
	Hardware_Init();

	//Delay slightly to let I/O settle
	_delay_ms(10);

	Modem_Reset();

	/*
	//LED Timing test
	while (1)
	{
		VBUS_ENABLE
		_delay_ms(1000);
		VBUS_DISABLE
		_delay_ms(1000);
	}
	*/


	/********************
	Begin
	********************/
	while (1)
	{
		AutoOn = GetAutoOn();		//Check if we are running with Auto-On
		PWRMONStatus = GetPWRMON();	//Update PWRMON status
		
		//Auto on is not being used, read PWRMON and act accordingly.
		if (!AutoOn)
		{ 

			//If PWRMON is read as being HIGH, we wait 7 seconds (5s ON/OFF possible hold + 2s boot up pause after ON/OFF release).
			//If it's already ON we don't touch it.
			if (PWRMONStatus && !VBUSStatus)
			{
				DB9_Enable();					//Enable the DB9 interface for quick interaction
				_delay_ms(7000); 				//7s delay
				VBUSStatus = Set_VBUS(ON);		//Turn VBUS Channel ON for readiness to the user
				V18_ENABLE						//Turn on the CODEC supply
			}

			//If PWRMON is read as being LOW, we turn VBUS off. If the interfaces are already OFF we don't touch it. 
			else if (!PWRMONStatus && VBUSStatus)
			{
				DB9_Disable();					//Kill the DB9 interface
				VBUSStatus = Set_VBUS(OFF); 	//Turn VBUS off
				V18_DISABLE						//Kill the CODEC supply
			}


		} //If end

		//Automatic turn on, check for PWRMON and act accordingly. Attempt turn on, if turn on is OK enable VBUS
		else
		{

			while (!PWRMONStatus && i <= POWERUP_TRIES)
			{
				_delay_ms(1000);				//Wait 1s per the Telit timing chart (supply activated, wait 1s before trying ON/OFF)
				Modem_TurnON(STD_ONOFF_TIME);	//Toggle ON/OFF Low for 3s

				_delay_ms(3000); 			//Wait for the modem to warm up
				i++; 						//increment counter
				PWRMONStatus = GetPWRMON(); //Update PWRMON status

			} //If End

			//Attempts failed
			if (!PWRMONStatus && i >= POWERUP_TRIES)
			{
				Modem_Reset(); //If we've tried at least 5 times and still no turn on, hit the reset signal for 1s to hardware reboot the modem. 
			}

			i = 0; //Reset counter if it passes or fails power on


			//If PWRMON is read as being HIGH, turn on the interfaces. We've already waited 5s (3s turn on + 3s delay)
			//If the interfaces are ON we don't touch it.
			if (PWRMONStatus && !VBUSStatus)
			{
				DB9_Enable();					//Enable the DB9 interface for quick interaction
				VBUSStatus = Set_VBUS(ON);		//Turn VBUS Channel ON for readiness to the user
				V18_ENABLE						//Turn on the CODEC supply
			}

			//If PWRMON is read as being LOW, we turn VBUS off. If it's already OFF we don't touch it. 
			else if (!PWRMONStatus && VBUSStatus)
			{
				DB9_Disable();					//Kill the DB9 interface
				VBUSStatus = Set_VBUS(OFF); 	//Turn VBUS off
				V18_DISABLE						//Kill the CODEC supply
			}

		}//else end


	}//While End

  return 1;

}//Main End
