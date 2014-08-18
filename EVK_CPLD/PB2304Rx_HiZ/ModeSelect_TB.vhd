--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   14:18:04 04/18/2011
-- Design Name:   
-- Module Name:   Z:/M2MProducts/M2M/Terminus_Family/Plug-in Modules/CF_Eval_Board/Firmware/PB2304R2/ModeSelect_TB.vhd
-- Project Name:  PB2304R2_TEST
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: ModeSelect
-- 
-- Dependencies:
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
--
-- Notes: 
-- This testbench has been automatically generated using types std_logic and
-- std_logic_vector for the ports of the unit under test.  Xilinx recommends
-- that these types always be used for the top-level I/O of a design in order
-- to guarantee that the testbench will bind correctly to the post-implementation 
-- simulation model.
--------------------------------------------------------------------------------
LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.std_logic_unsigned.all;
USE ieee.numeric_std.ALL;
 
ENTITY ModeSelect_TB IS
END ModeSelect_TB;
 
ARCHITECTURE behavior OF ModeSelect_TB IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT ModeSelect
    PORT(
         MODE : IN  std_logic_vector(1 downto 0);
         GSM_RX : IN  std_logic;
         GSM_LD_TX : IN  std_logic;
         GSM_DSR : IN  std_logic;
         GSM_CTS : IN  std_logic;
         GSM_RING : IN  std_logic;
         GSM_DCD : IN  std_logic;
         GSM_LD_RX : OUT  std_logic;
         GSM_TX : OUT  std_logic;
         GSM_LD_DSR : OUT  std_logic;
         GSM_LD_CTS : OUT  std_logic;
         GSM_LD_RING : OUT  std_logic;
         GSM_LD_DCD : OUT  std_logic;
         GSM_DTR : OUT  std_logic;
         GSM_RTS : OUT  std_logic;
         GSM_LD_DTR : IN  std_logic;
         GSM_LD_RTS : IN  std_logic;
         GPS_RX : OUT  std_logic;
         GPS_TX : IN  std_logic;
         GPS_LD_RX : IN  std_logic;
         GPS_LD_TX : OUT  std_logic;
         TRACE_RX : OUT  std_logic;
         TRACE_TX : IN  std_logic;
         TRACE_LD_TX : OUT  std_logic;
         TRACE_LD_RX : IN  std_logic;
         SERVICE_IN : IN  std_logic;
         SERVICE_OUT : OUT  std_logic;
         nFORCEOFF_LD0 : OUT  std_logic;
         nFORCEOFF_LD1 : OUT  std_logic;
         FORCEON_LD0 : OUT  std_logic;
         FORCEON_LD1 : OUT  std_logic
        );
    END COMPONENT;
    

   --Inputs
   signal MODE : std_logic_vector(1 downto 0) := (others => '0');
   signal GSM_RX : std_logic := '0';
   signal GSM_LD_TX : std_logic := '0';
   signal GSM_DSR : std_logic := '0';
   signal GSM_CTS : std_logic := '0';
   signal GSM_RING : std_logic := '0';
   signal GSM_DCD : std_logic := '0';
   signal GSM_LD_DTR : std_logic := '0';
   signal GSM_LD_RTS : std_logic := '0';
   signal GPS_TX : std_logic := '0';
   signal GPS_LD_RX : std_logic := '0';
   signal TRACE_TX : std_logic := '0';
   signal TRACE_LD_RX : std_logic := '0';
   signal SERVICE_IN : std_logic := '0';

 	--Outputs
   signal GSM_LD_RX : std_logic;
   signal GSM_TX : std_logic;
   signal GSM_LD_DSR : std_logic;
   signal GSM_LD_CTS : std_logic;
   signal GSM_LD_RING : std_logic;
   signal GSM_LD_DCD : std_logic;
   signal GSM_DTR : std_logic;
   signal GSM_RTS : std_logic;
   signal GPS_RX : std_logic;
   signal GPS_LD_TX : std_logic;
   signal TRACE_RX : std_logic;
   signal TRACE_LD_TX : std_logic;
   signal SERVICE_OUT : std_logic;
   signal nFORCEOFF_LD0 : std_logic;
   signal nFORCEOFF_LD1 : std_logic;
   signal FORCEON_LD0 : std_logic;
   signal FORCEON_LD1 : std_logic;
	
   -- Clock period definitions
   constant CLK_trace : time := 10 ns;	
	constant CLK_nmea : time := 20 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: ModeSelect PORT MAP (
          MODE => MODE,
          GSM_RX => GSM_RX,
          GSM_LD_TX => GSM_LD_TX,
          GSM_DSR => GSM_DSR,
          GSM_CTS => GSM_CTS,
          GSM_RING => GSM_RING,
          GSM_DCD => GSM_DCD,
          GSM_LD_RX => GSM_LD_RX,
          GSM_TX => GSM_TX,
          GSM_LD_DSR => GSM_LD_DSR,
          GSM_LD_CTS => GSM_LD_CTS,
          GSM_LD_RING => GSM_LD_RING,
          GSM_LD_DCD => GSM_LD_DCD,
          GSM_DTR => GSM_DTR,
          GSM_RTS => GSM_RTS,
          GSM_LD_DTR => GSM_LD_DTR,
          GSM_LD_RTS => GSM_LD_RTS,
          GPS_RX => GPS_RX,
          GPS_TX => GPS_TX,
          GPS_LD_RX => GPS_LD_RX,
          GPS_LD_TX => GPS_LD_TX,
          TRACE_RX => TRACE_RX,
          TRACE_TX => TRACE_TX,
          TRACE_LD_TX => TRACE_LD_TX,
          TRACE_LD_RX => TRACE_LD_RX,
          SERVICE_IN => SERVICE_IN,
          SERVICE_OUT => SERVICE_OUT,
          nFORCEOFF_LD0 => nFORCEOFF_LD0,
          nFORCEOFF_LD1 => nFORCEOFF_LD1,
          FORCEON_LD0 => FORCEON_LD0,
          FORCEON_LD1 => FORCEON_LD1
        );
 
   -- No clocks detected in port list. Replace <clock> below with 
   -- appropriate port name 
 
   -- Clock process definitions
   CLK_process :process
   begin
		TRACE_TX <= '0';
		wait for CLK_trace/2;
		TRACE_TX <= '1';
		wait for CLK_trace/2;
   end process;
	
   CLK_process2 :process
   begin
		GPS_TX <= '0';
		wait for CLK_nmea/2;
		GPS_TX <= '1';
		wait for CLK_nmea/2;
   end process;	
 

   -- Stimulus process
   stim_proc: process
   begin		
      wait for 2 ms;
		MODE <= "11";
      wait for 2 ms;
		MODE <= "10";
      wait for 2 ms;
		MODE <= "01";		
      wait for 2 ms;
		MODE <= "00";
      wait;
   end process;

END;
