--------------------------------------------------------------------------------
-- Copyright (c) 1995-2009 Xilinx, Inc.  All rights reserved.
--------------------------------------------------------------------------------
--   ____  ____ 
--  /   /\/   / 
-- /___/  \  /    Vendor: Xilinx 
-- \   \   \/     Version : 11.4
--  \   \         Application : sch2hdl
--  /   /         Filename : ModeSelect_sch.vhf
-- /___/   /\     Timestamp : 07/07/2011 09:57:21
-- \   \  /  \ 
--  \___\/\___\ 
--
--Command: sch2hdl -intstyle ise -family xbr -flat -suppress -vhdl "Z:/M2MProducts/M2M/Terminus_Family/Plug-in Modules/CF_Eval_Board/Firmware/PB2304Rx_HiZ/ModeSelect_sch.vhf" -w "Z:/M2MProducts/M2M/Terminus_Family/Plug-in Modules/CF_Eval_Board/Firmware/PB2304Rx_HiZ/ModeSelect_sch.sch"
--Design Name: ModeSelect_sch
--Device: xbr
--Purpose:
--    This vhdl netlist is translated from an ECS schematic. It can be 
--    synthesized and simulated, but it should not be modified. 
--

library ieee;
use ieee.std_logic_1164.ALL;
use ieee.numeric_std.ALL;
library UNISIM;
use UNISIM.Vcomponents.ALL;

entity ModeSelect_sch is
   port ( GPS_LD_RX     : in    std_logic; 
          GPS_TX        : in    std_logic; 
          GSM_CTS       : in    std_logic; 
          GSM_DCD       : in    std_logic; 
          GSM_DSR       : in    std_logic; 
          GSM_LD_DTR    : in    std_logic; 
          GSM_LD_RTS    : in    std_logic; 
          GSM_LD_TX     : in    std_logic; 
          GSM_RING      : in    std_logic; 
          GSM_RX        : in    std_logic; 
          MODE          : in    std_logic_vector (1 downto 0); 
          SERVICE_IN    : in    std_logic; 
          TRACE_LD_RX   : in    std_logic; 
          TRACE_TX      : in    std_logic; 
          FORCEON_LD0   : out   std_logic; 
          FORCEON_LD1   : out   std_logic; 
          GPS_LD_TX     : out   std_logic; 
          GPS_RX        : out   std_logic; 
          GSM_DTR       : out   std_logic; 
          GSM_LD_CTS    : out   std_logic; 
          GSM_LD_DCD    : out   std_logic; 
          GSM_LD_DSR    : out   std_logic; 
          GSM_LD_RING   : out   std_logic; 
          GSM_LD_RX     : out   std_logic; 
          GSM_RTS       : out   std_logic; 
          GSM_TX        : out   std_logic; 
          nFORCEOFF_LD0 : out   std_logic; 
          nFORCEOFF_LD1 : out   std_logic; 
          SERVICE_OUT   : out   std_logic; 
          TRACE_LD_TX   : out   std_logic; 
          TRACE_RX      : out   std_logic);
end ModeSelect_sch;

architecture BEHAVIORAL of ModeSelect_sch is
   component ModeSelect
      port ( GSM_RX        : in    std_logic; 
             GSM_LD_TX     : in    std_logic; 
             GSM_DSR       : in    std_logic; 
             GSM_CTS       : in    std_logic; 
             GSM_RING      : in    std_logic; 
             GSM_DCD       : in    std_logic; 
             GSM_LD_DTR    : in    std_logic; 
             GSM_LD_RTS    : in    std_logic; 
             GPS_TX        : in    std_logic; 
             GPS_LD_RX     : in    std_logic; 
             TRACE_TX      : in    std_logic; 
             TRACE_LD_RX   : in    std_logic; 
             MODE          : in    std_logic_vector (1 downto 0); 
             GSM_LD_RX     : out   std_logic; 
             GSM_TX        : out   std_logic; 
             GSM_LD_DSR    : out   std_logic; 
             GSM_LD_CTS    : out   std_logic; 
             GSM_LD_RING   : out   std_logic; 
             GSM_LD_DCD    : out   std_logic; 
             GSM_DTR       : out   std_logic; 
             GSM_RTS       : out   std_logic; 
             GPS_RX        : out   std_logic; 
             GPS_LD_TX     : out   std_logic; 
             TRACE_RX      : out   std_logic; 
             TRACE_LD_TX   : out   std_logic; 
             nFORCEOFF_LD0 : out   std_logic; 
             nFORCEOFF_LD1 : out   std_logic; 
             FORCEON_LD0   : out   std_logic; 
             FORCEON_LD1   : out   std_logic; 
             SERVICE_IN    : in    std_logic; 
             SERVICE_OUT   : out   std_logic);
   end component;
   
begin
   Mode_Sel : ModeSelect
      port map (GPS_LD_RX=>GPS_LD_RX,
                GPS_TX=>GPS_TX,
                GSM_CTS=>GSM_CTS,
                GSM_DCD=>GSM_DCD,
                GSM_DSR=>GSM_DSR,
                GSM_LD_DTR=>GSM_LD_DTR,
                GSM_LD_RTS=>GSM_LD_RTS,
                GSM_LD_TX=>GSM_LD_TX,
                GSM_RING=>GSM_RING,
                GSM_RX=>GSM_RX,
                MODE(1 downto 0)=>MODE(1 downto 0),
                SERVICE_IN=>SERVICE_IN,
                TRACE_LD_RX=>TRACE_LD_RX,
                TRACE_TX=>TRACE_TX,
                FORCEON_LD0=>FORCEON_LD0,
                FORCEON_LD1=>FORCEON_LD1,
                GPS_LD_TX=>GPS_LD_TX,
                GPS_RX=>GPS_RX,
                GSM_DTR=>GSM_DTR,
                GSM_LD_CTS=>GSM_LD_CTS,
                GSM_LD_DCD=>GSM_LD_DCD,
                GSM_LD_DSR=>GSM_LD_DSR,
                GSM_LD_RING=>GSM_LD_RING,
                GSM_LD_RX=>GSM_LD_RX,
                GSM_RTS=>GSM_RTS,
                GSM_TX=>GSM_TX,
                nFORCEOFF_LD0=>nFORCEOFF_LD0,
                nFORCEOFF_LD1=>nFORCEOFF_LD1,
                SERVICE_OUT=>SERVICE_OUT,
                TRACE_LD_TX=>TRACE_LD_TX,
                TRACE_RX=>TRACE_RX);
   
end BEHAVIORAL;


