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
          13 => "01101001",   -- i  0x69
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
					when OTHERS  => Data <= "00100000";
				end case;
			end if;
		end process;
	
	end Behavioural;
