----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    15:37:48 12/14/2011 
-- Design Name: 
-- Module Name:    Baud_Gen - Behavioral 
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

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity Baud_Gen is
    --Generic ( Counts : integer := 5208333  );
    Generic ( Counts : integer := 10  );

    Port ( Clk_In   : in   STD_LOGIC;
           Baud_Out : out  STD_LOGIC);
end Baud_Gen;

architecture Behavioral of Baud_Gen is

   signal count   : integer := 0;
   signal output  : STD_LOGIC := '0';

begin
   State_counter : Process ( Clk_In, count )
   begin
      if ( Clk_In 'event and Clk_In = '1' ) then
        if ( count < Counts ) then
          count <= ( count + 1 );
          output <= output;
        else
          count <= 0;
          output <= ( not output );
        end if;
      end if;
   end process;

Baud_out <= output;

end Behavioral;

