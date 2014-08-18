----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    16:31:16 09/18/2009 
-- Design Name: 
-- Module Name:    ModeSelect - Behavioral 
-- Project Name: 
-- Target Devices: 
-- Tool versions: 
-- Description: 
--
-- Dependencies: 
--
-- Revision: 
-- Revision 0.01 - File Created
-- Additional Comments: 
--
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

---- Uncomment the following library declaration if instantiating
---- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity ModeSelect is
	Port	(
				MODE : in STD_LOGIC_VECTOR(1 downto 0);
				GSM_RX : in STD_LOGIC;
				GSM_LD_TX : in STD_LOGIC;			  
				GSM_DSR : in STD_LOGIC;
				GSM_CTS : in STD_LOGIC;
				GSM_RING : in STD_LOGIC;
				GSM_DCD : in STD_LOGIC;
				GSM_LD_RX : out STD_LOGIC;
				GSM_TX : out STD_LOGIC;			  
				GSM_LD_DSR : out STD_LOGIC;			  
				GSM_LD_CTS : out STD_LOGIC;
				GSM_LD_RING : out STD_LOGIC;			  
				GSM_LD_DCD : out STD_LOGIC;	
				GSM_DTR : out STD_LOGIC;
				GSM_RTS : out STD_LOGIC;
				GSM_LD_DTR : in STD_LOGIC;
				GSM_LD_RTS : in STD_LOGIC;

				GPS_RX : out STD_LOGIC;
				GPS_TX : in STD_LOGIC;
				GPS_LD_RX : in  STD_LOGIC;
				GPS_LD_TX : out  STD_LOGIC;			  

				TRACE_RX : out STD_LOGIC; --Added 3/9/10 C.K.
				TRACE_TX : in STD_LOGIC; --Added 3/9/10 C.K.
				TRACE_LD_TX : out STD_LOGIC;
				TRACE_LD_RX : in STD_LOGIC; --Added 3/9/10 C.K.
				
				SERVICE_IN : in STD_LOGIC; --added 4/12/10 C.K.
				SERVICE_OUT : out STD_LOGIC := '1'; --added 4/12/10 C.K.
						  
				nFORCEOFF_LD0 : out STD_LOGIC;
				nFORCEOFF_LD1 : out STD_LOGIC;
				FORCEON_LD0 : out STD_LOGIC;
				FORCEON_LD1 : out STD_LOGIC
			);
			  
end ModeSelect;

architecture Behavioral of ModeSelect is
-------------------------------------------------------------------
--Signal/Constant Declaration

-------------------------------------------------------------------

begin

--------------------------------------------------------------
--------------------------------------------------------------
--Processes

process (MODE(0), MODE(1), GSM_LD_TX, GSM_RX, GSM_DSR, GSM_CTS, GSM_RING, GSM_DCD, GSM_LD_DTR, GSM_LD_RTS,GPS_TX, GPS_LD_RX, TRACE_TX, TRACE_LD_RX, SERVICE_IN)
	-- Control Enable state of RS232 Line Drivers. 
	-- MODE0 HIGH = line drivers active, lines routed 
	-- MODE0 LOW = line drivers not active, lines in hi-Z
	
	begin
		case MODE(0) is 
            when '1' =>
				
					GSM_TX <= GSM_LD_TX;
					GSM_LD_RX <= GSM_RX;
					GSM_LD_DSR <= GSM_DSR; 			  
					GSM_LD_CTS <= GSM_CTS;
					GSM_LD_RING <= GSM_RING; 			  
					GSM_LD_DCD <= GSM_DCD;
					GSM_DTR <= GSM_LD_DTR;
					GSM_RTS <= GSM_LD_RTS;
					
					-- SERVICE Signal Routes
					SERVICE_OUT <= SERVICE_IN; -- Added 4/12/10 C.K.
					
					-- Line Drivers for the RS232
					nFORCEOFF_LD0 <= '1';
					nFORCEOFF_LD1 <= '1';
					FORCEON_LD0 <= '1';
					FORCEON_LD1 <= '1';						
					
					-- MODE 1 Null Modem functionality
					
					if MODE(1) = '1' then
						-- GPS Signal Routes Normal
						GPS_LD_TX <= GPS_TX;
						GPS_RX <= GPS_LD_RX;
						
						-- TRACE Signal Routes Normal
						TRACE_LD_TX <= TRACE_TX;
						TRACE_RX <= TRACE_LD_RX;
						
					else
						-- GPS Signal Routes Null Modem
						GPS_LD_TX <= GPS_TX;
						GPS_RX <= TRACE_TX;
						
						-- TRACE Signal Routes Null Modem
						TRACE_LD_TX <= TRACE_TX;
						TRACE_RX <= GPS_TX; 	
					end if;

					

					
				when '0' =>
				
					nFORCEOFF_LD0 <= 'Z';
					nFORCEOFF_LD1 <= 'Z';
					FORCEON_LD0 <= 'Z';
					FORCEON_LD1 <= 'Z';
				
					SERVICE_OUT	<= 'Z';
					
					-- UART Signal Routes
					GSM_TX <= 'Z';
					GSM_LD_RX <= 'Z';
					GSM_LD_DSR <= 'Z';			  
					GSM_LD_CTS <= 'Z';
					GSM_LD_RING <= 'Z';			  
					GSM_LD_DCD <= 'Z';
					GSM_DTR <= 'Z';
					GSM_RTS <= 'Z';

					-- GPS Signal Routes
					GPS_LD_TX <= 'Z';
					GPS_RX <= 'Z';
					
					-- TRACE Signal Routes
					TRACE_LD_TX <= 'Z';
					TRACE_RX <= 'Z'; --Added 3/9/10 C.K.					
					
				when others =>	
				
					nFORCEOFF_LD0 <= 'Z';
					nFORCEOFF_LD1 <= 'Z';
					FORCEON_LD0 <= 'Z';
					FORCEON_LD1 <= 'Z';
				
					SERVICE_OUT	<= 'Z';	

					-- UART Signal Routes					
					GSM_TX <= 'Z';
					GSM_LD_RX <= 'Z';
					GSM_LD_DSR <= 'Z';			  
					GSM_LD_CTS <= 'Z';
					GSM_LD_RING <= 'Z';			  
					GSM_LD_DCD <= 'Z';
					GSM_DTR <= 'Z';
					GSM_RTS <= 'Z';

					-- GPS Signal Routes
					GPS_LD_TX <= 'Z';
					GPS_RX <= 'Z';
					
					-- TRACE Signal Routes
					TRACE_LD_TX <= 'Z';
					TRACE_RX <= 'Z';
					
				
        end case; 
    end process;	 
end Behavioral;

