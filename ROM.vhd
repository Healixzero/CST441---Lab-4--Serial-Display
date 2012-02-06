----------------------------------------------------------------------------------
-- Company:        Oregon Institute of Technology
-- Engineer:       Brent Honzaki
-- 
-- Create Date:    11:23:18 1/18/2012
-- Design Name:    Serial Display
-- Module Name:    ROM - Behavioral 
-- Project Name:   LAB4 : Serial Display Lab
-- Target Devices: Automotive Spartan 3 3S200-FTG256
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

entity ROM is
   port ( CLK  : in  STD_LOGIC;
          RST  : in  STD_LOGIC;
          EN   : in  STD_LOGIC;
          ADDR : in  STD_LOGIC_VECTOR ( 4 downto 0 );
          Data : out STD_LOGIC_VECTOR ( 7 downto 0 )
         );
   end ROM;

architecture Behavioural of ROM is
   type ROM_Array is array ( 0 to 31 )
      of STD_LOGIC_VECTOR ( 7 downto 0 );
   constant Contents: ROM_Array := (
          0  => "00001100",   --    0x0C Clear Screen
          1  => "01000010",   -- B  0x42
          2  => "01110010",   -- r  0x72
          3  => "01100101",   -- e  0x65
          4  => "01101110",   -- n  0x6E
          5  => "01111000",   -- t  0x74
          6  => "00100000",   --    0x20
          7  => "01001000",   -- H  0x48
          8  => "01101111",   -- o  0x4F
          9  => "01101110",   -- n  0x6E
          10 => "01111010",   -- z  0x7A
          11 => "01100001",   -- a  0x61
          12 => "01101011",   -- k  0x6B
          13 => "00100000",   --    0x20
          14 => "00100000",   --    0x20
          15 => "00100000",   --    0x20
          16 => "00100000",   --    0x20
          17 => "00100000",   --    0x20
          18 => "00100000",   --    0x20
          19 => "00100000",   --    0x20
          20 => "00100000",   --    0x20
          21 => "00100000",   --    0x20
          22 => "00100000",   --    0x20
          23 => "00100000",   --    0x20
          24 => "00100000",   --    0x20
          25 => "00100000",   --    0x20
          26 => "00100000",   --    0x20
          27 => "00100000",   --    0x20
          28 => "00100000",   --    0x20
          29 => "00100000",   --    0x20
          30 => "00100000",   --    0x20
          31 => "00100000",   --    0x20
          32 => "00100000",   --    0x20
      OTHERS => "00100000",   --    0x20
      );
