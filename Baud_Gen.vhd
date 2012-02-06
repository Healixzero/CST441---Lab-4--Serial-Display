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
    Generic ( Counts : integer :=  );

    Port ( Clk_In   : in  STD_LOGIC;
           Baud_Out : in  STD_LOGIC);
end Baud_Gen;

architecture Behavioral of Baud_Gen is

begin


end Behavioral;

