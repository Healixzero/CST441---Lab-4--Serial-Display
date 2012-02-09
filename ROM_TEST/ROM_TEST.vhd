----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    15:09:05 02/08/2012 
-- Design Name: 
-- Module Name:    ROM_TEST - Behavioral 
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

entity ROM_TEST is
end ROM_TEST;

architecture Testbench of ROM_TEST is

	component ROM
		port ( EN    in  : STD_LOGIC;
		       ADDR  in  : STD_LOGIC_VECTOR ( 4 downto 0 );
				 Data  out : STD_LOGIC_VECTOR ( 7 downto 0 ) );
	end component;

   -- coversion funtion
   function TO_SLV ( Data : natural )
                    return STD_LOGIC_VECTOR is
      variable Result : STD_LOGIC_VECTOR ( 4 downto 0 );
   begin
      case ( Data ) is 
         when 0      => Result := "00000";
         when 1      => Result := "00001";
         when 2      => Result := "00010";
         when 3      => Result := "00011";
         when 4      => Result := "00100";
         when 5      => Result := "00101";
         when 6      => Result := "00110";
         when 7      => Result := "00111";
         when 8      => Result := "01000";
         when 9      => Result := "01001";
         when 10     => Result := "01010";
         when 11     => Result := "01011";
         when 12     => Result := "01100";
         when 13     => Result := "01101";
         when 14     => Result := "01110";
         when 15     => Result := "01111";
         when 16     => Result := "10000";
         when 17     => Result := "10001";
         when 18     => Result := "10010";
         when 19     => Result := "10011";
         when 20     => Result := "10100";
         when 21     => Result := "10101";
         when 22     => Result := "10110";
         when 23     => Result := "10111";
         when 24     => Result := "11000";
         when 25     => Result := "11001";
         when 26     => Result := "11010";
         when 27     => Result := "11011";
         when 28     => Result := "11100";
         when 29     => Result := "11101";
         when 30     => Result := "11110";
         when 31     => Result := "11111";
         when others => Result := "00000";
      end case;
      return Result;
   end function;

	-- test signals
	signal enable   : STD_LOGIC;
	signal address  : STD_LOGIC_VECTOR ( 4 downto 0 );
	signal data_out : STD_LOGIC_VECTOR ( 7 downto 0 );
	
	constant inertial_time : time := 20 ns;
	constant prop_time : time := 5 ns;
	
begin
	DUT_PORT_MAP : ROM port map (
		EN   => enable,
		ADDR => address,
		Data => data_out );
		
		DUT_TEST : process
		begin
			enable <= '1';
			for i in 0 to 31 loop
				ADDR = TO_SLV(i);
				wait for inertial_time;
			end loop;
			enable <= '0';
			for i in 0 to 31 loop
				ADDR = TO_SLV(i);
				wait for interital_time;
			end loop;
		end process;

end Behavioral;

