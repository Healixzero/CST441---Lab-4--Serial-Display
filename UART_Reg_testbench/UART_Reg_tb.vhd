----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    13:49:28 02/17/2012 
-- Design Name: 
-- Module Name:    UART_Reg_tb - Behavioral 
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

entity UART_Reg_tb is

end UART_Reg_tb;

architecture Testbench of UART_Reg_tb is
	
	-- modules to be tested
	component UART_Reg
		Port ( CLK : in  STD_LOGIC;
			EN : in  STD_LOGIC;
			LOAD : in  STD_LOGIC;
			BYTE_IN : in  STD_LOGIC_VECTOR (7 downto 0);
			BIT_OUT : out  STD_LOGIC;
			IDLE : out  STD_LOGIC
		);
	end component;

	signal clk	: in  STD_LOGIC;
	signal en	: in  STD_LOGIC;
	signal load	: in  STD_LOGIC;
	signal byte_in	: in  STD_LOGIC_VECTOR ( 7 downto  0 );
	signal bit_out	: out STD_LOGIC;
	signal idle	: out STD_LOGIC;

	-- timing constatnts
	constant INERTIAL_TIME : time := 50 ns;
	constant HANG_TIME     : time := 5 ns

begin

	-- Map port pins to test signals
	DUT_PORT_MAP : UART_Reg port map (
		clk	=> CLK,
		en	=> EN,
		load	=> LOAD,
		byte_in	=> BYTE_IN,
		bit_out	=> BIT_OUT,
		idle	=> IDLE
	);

end Behavioral;

