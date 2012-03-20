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
   port ( EN   : in  STD_LOGIC;
          ADDR : in  STD_LOGIC_VECTOR ( 4 downto 0 );
          Data : out STD_LOGIC_VECTOR ( 7 downto 0 )
         );
   end ROM;

architecture Behavioural of ROM is
   type ROM_Array is array ( 0 to 31 )
      of STD_LOGIC_VECTOR ( 7 downto 0 );
   constant Contents: ROM_Array := (
          0  => "00100000",   --    0x20 Space for timing F
          1  => "00001100",   --    0x0C Clear Screen
			 2  => "00000001",   --    0x01 Cursor home (delaying for Clear screen)
          3  => "01000010",   -- B  0x42
          4  => "01110010",   -- r  0x72
          5  => "01100101",   -- e  0x65
          6  => "01101110",   -- n  0x6E
          7  => "01110100",   -- t  0x74
          8  => "00100000",   --    0x20 T
          9  => "01001000",   -- H  0x48
          10 => "01101111",   -- o  0x6F
          11 => "01101110",   -- n  0x6E
          12 => "01111010",   -- z  0x7A
          13 => "01100001",   -- a  0x61
          14 => "01101011",   -- k  0x6B
          15 => "01101001",   -- i  0x69
			 OTHERS => "00100000"    --    0x20
      );
	
	begin
	process ( EN, ADDR )
		begin
			if ( EN = '1' ) then
				case ADDR is
					when "00000" => Data <= Contents( 0  );
					when "00001" => Data <= Contents( 1  );
					when "00010" => Data <= Contents( 2  );
					when "00011" => Data <= Contents( 3  );
					when "00100" => Data <= Contents( 4  );
					when "00101" => Data <= Contents( 5  );
					when "00110" => Data <= Contents( 6  );
					when "00111" => Data <= Contents( 7  );
					when "01000" => Data <= Contents( 8  );
					when "01001" => Data <= Contents( 9  );
					when "01010" => Data <= Contents( 10 );
					when "01011" => Data <= Contents( 11 );
					when "01100" => Data <= Contents( 12 );
					when "01101" => Data <= Contents( 13 );
					when "01110" => Data <= Contents( 14 );
					when "01111" => Data <= Contents( 15 );
					when "10000" => Data <= Contents( 16 );
					when "10001" => Data <= Contents( 17 );
					when "10010" => Data <= Contents( 18 );
					when "10011" => Data <= Contents( 19 );
					when "10100" => Data <= Contents( 20 );
					when "10101" => Data <= Contents( 21 );
					when "10110" => Data <= Contents( 22 );
					when "10111" => Data <= Contents( 23 );
					when "11000" => Data <= Contents( 24 );
					when "11001" => Data <= Contents( 25 );
					when "11010" => Data <= Contents( 26 );
					when "11011" => Data <= Contents( 27 );
					when "11100" => Data <= Contents( 28 );
					when "11101" => Data <= Contents( 29 );
					when "11110" => Data <= Contents( 30 );
					when "11111" => Data <= Contents( 31 );
					when OTHERS  => Data <= "00100000";
				end case;
			end if;
		end process;
	
	end Behavioural;
