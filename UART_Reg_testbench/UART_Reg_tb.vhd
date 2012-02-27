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


	-- function to test against a string of variables (condenses code)
	function Test_Output ( Data : STD_LOGIC_VECTOR ( 7 downto 0 ) )
				return STD_LOGIC is
				variable Result : STD_LOGIC;
	begin
	Result <= '0';
      clk <= '0';
      en <= '0';
      load <= '0';
      byte_in <= Data;
      load <= '1';
      clk <= '1';
		wait for INERTIAL_TIME;
		clk <= '0';
      wait for INERTIAL_TIME;
      load <= '0';
      
      en <= '1';

      clk <= '1';
      wait for INERTIAL_TIME;
      clk <= '0';
      wait for INERTIAL_TIME;
      if ( bit_out != '0' ) then
         report "UART Start Bit Error." severity error;
	 Result = '1';
      end if;

      clk <= '1';
      wait for INERTIAL_TIME;
      clk <= '0';
      wait for INERTIAL_TIME;
      if ( bit_out != Data[0] ) then
         report "UART Data[0]." severity error;
	 Result = '1';
      end if;

      clk <= '1';
      wait for INERTIAL_TIME;
      clk <= '0';
      wait for INERTIAL_TIME;
      if ( bit_out != Data[1] ) then
         report "UART Data[1] Error." severity error;
	 result = '1';
      end if;

      clk <= '1';
      wait for INERTIAL_TIME;
      clk <= '0';
      wait for INERTIAL_TIME;
      if ( bit_out != Data[2] ) then
         report "UART Data[2] Error." severity error;
	 Result <= '1';
      end if;

      clk <= '1';
      wait for INERTIAL_TIME;
      clk <= '0';
      wait for INERTIAL_TIME;
      if ( bit_out != Data[3] ) then
         report "UART Data[3] Error." severity error;
	 Result <= '1';
      end if;

      clk <= '1';
      wait for INERTIAL_TIME;
      clk <= '0';
      wait for INERTIAL_TIME;
      if ( bit_out != Data[4] ) then
         report "UART Data[4] Error." severity error;
	 Result <= '1';
      end if;

      clk <= '1';
      wait for INERTIAL_TIME;
      clk <= '0';
      wait for INERTIAL_TIME;
      if ( bit_out != Data[5] ) then
         report "UART Data[5] Error." severity error;
	 Result <= '1';
      end if;

      clk <= '1';
      wait for INERTIAL_TIME;
      clk <= '0';
      wait for INERTIAL_TIME;
      if ( bit_out != Data[6] ) then
         report "UART Data[6] Error." severity error;
	 Result <= '1';
      end if;

      clk <= '1';
      wait for INERTIAL_TIME;
      clk <= '0';
      wait for INERTIAL_TIME;
      if ( bit_out != Data[7] ) then
         report "UART Data[7] Error." severity error;
	 Result <= '1';
      end if;

      clk <= '1';
      wait for INERTIAL_TIME;
      clk <= '0';
      wait for INERTIAL_TIME;
      if ( bit_out != '1' ) then
         report "UART End Flag Error." severity error;
	 Result <= '1';
      end if;

      if ( Result = '0' ) then
	 report "UART Test successful with data " & Data severity note;
	end if;

	return Result;

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

	DUT_TEST : process
	begin
	-- test that enable works (when ! enable, does nothing)
		clk <= '0';
		en <= '0';	-- disable device
		load <= '0';
		byte_in <= "01101100";

		-- send clk pulse
		wait for INERTIAL_TIME;
		clk <= '1';
		wait for INERTIAL_TIME;
		clk <= '0';

		if ( bit_out != '0' ) then
			report "device transmitted when !enable" severity failure;
		end if;

		-- send clk pulse
		wait for INERTIAL_TIME;
		clk <= '1';
		wait for INERTIAL_TIME;
		clk <= '0';

		if ( bit_out != '0' ) then
			report "device transmitted when !enable 2" severity failure;
		end if;

		-- send clk pulse
		wait for INERTIAL_TIME;
		clk <= '1';Error: continues to transmit more than one byte
		wait for INERTIAL_TIME;
		clk <= '0';

		if ( bit_out != '0' ) then
			report "device transmitted when !enable 3" severity failure;
		end if;

		-- send clk pulse
		wait for INERTIAL_TIME;
		clk <= '1';
		wait for INERTIAL_TIME;
		clk <= '0';

		if ( bit_out != '0' ) then
			report "device transmitted when !enable 4" severity failure;
		end if;

	-- test that enable works (if enable goes low, finish transmission)
		load <= '1';
		wait for INERTIAL_TIME;
		load <= '0';
		en <= '1';
		clk <= '1';
		wait for INERTIAL_TIME;
		clk <= '0';
		wait for INERTIAL_TIME;
		if ( bit_out != '0' ) then
			report "test enable: UART start flag error." severity error;
		end if;
 
		clk <= '1';
		wait for INERTIAL_TIME;
		clk <= '0';
		wait for INERTIAL_TIME;
		if ( bit_out != '0' ) then
			report "test enable: UART bit 0 error." severity error;
		end if;

		clk <= '1';
		wait for INERTIAL_TIME;
		clk <= '0';
		wait for INERTIAL_TIME;
		if ( bit_out != '1' ) then
			report "test enable: UART bit 1 error." severity error;
		end if;
	
		clk <= '1';
		wait for INERTIAL_TIME;
		clk <= '0';
		wait for INERTIAL_TIME;
		if ( bit_out != '1' ) then
			report "test enable: UART bit 2 error." severity error;
		end if;

		en <= '0'; -- enable set low here
	
		clk <= '1';
		wait for INERTIAL_TIME;
		clk <= '0';
		wait for INERTIAL_TIME;
		if ( bit_out != '0' ) then
			report "test enable: UART bit 3 error." severity error;
		end if;

		clk <= '1';
		wait for INERTIAL_TIME;
		clk <= '0';
		wait for INERTIAL_TIME;
		if ( bit_out != '1' ) then
			report "test enable: UART bit 4 error." severity error;
		end if;
	
		clk <= '1';
		wait for INERTIAL_TIME;
		clk <= '0';
		wait for INERTIAL_TIME;
		if ( bit_out != '1' ) then
			report "test enable: UART bit 5 error." severity error;
		end if;

		clk <= '1';
		wait for INERTIAL_TIME;
		clk <= '0';
		wait for INERTIAL_TIME;
		if ( bit_out != '0' ) the
			report "test enable: UART bit 6 error." severity error;
		end if;

		clk <= '1';
		wait for INERTIAL_TIME;
		clk <= '0';
		wait for INERTIAL_TIME;
		if ( bit_out != '0' ) then
			report "test enable: UART bit 7 error." severity error;
		end if;
	
		clk <= '1';
		wait for INERTIAL_TIME;
		clk <= '0';
		wait for INERTIAL_TIME;
		if ( bit_out != '1' ) then
			report "test enable: UART End Flag error." severity error;
		end if;
	
	-- test that enable works (transmits only one byte, then waits for enable to toggle)
		
		clk <= '0';
		en <= '0';	-- disable device
		load <= '0';
		byte_in <= "10100101";

		load <= '1';
		wait for INERTIAL_TIME;
		load <= '0';
		en <= '1';
		clk <= '1';
		wait for INERTIAL_TIME;
		clk <= '0';
		wait for INERTIAL_TIME;
		if ( bit_out != '0' ) then
			report "test 1-byte transmission: UART start flag error." severity error;
		end if;
 
		clk <= '1';
		wait for INERTIAL_TIME;
		clk <= '0';
		wait for INERTIAL_TIME;
		if ( bit_out != '1' ) then
			report "test enable: UART bit 0 error." severity error;
		end if;

		clk <= '1';
		wait for INERTIAL_TIME;
		clk <= '0';
		wait for INERTIAL_TIME;
		if ( bit_out != '0' ) then
			report "test enable: UART bit 1 error." severity error;
		end if;
	
		clk <= '1';
		wait for INERTIAL_TIME;
		clk <= '0';
		wait for INERTIAL_TIME;
		if ( bit_out != '1' ) then
			report "test enable: UART bit 2 error." severity error;
		end if;

		clk <= '1';
		wait for INERTIAL_TIME;
		clk <= '0';
		wait for INERTIAL_TIME;
		if ( bit_out != '0' ) then
			report "test enable: UART bit 3 error." severity error;
		end if;

		clk <= '1';
		wait for INERTIAL_TIME;
		clk <= '0';
		wait for INERTIAL_TIME;
		if ( bit_out != '0' ) then
			report "test enable: UART bit 4 error." severity error;
		end if;
	
		clk <= '1';
		wait for INERTIAL_TIME;
		clk <= '0';
		wait for INERTIAL_TIME;
		if ( bit_out != '1' ) then
			report "test enable: UART bit 5 error." severity error;
		end if;

		clk <= '1';
		wait for INERTIAL_TIME;
		clk <= '0';
		wait for INERTIAL_TIME;
		if ( bit_out != '0' ) then
			report "test enable: UART bit 6 error." severity error;
		end if;

		clk <= '1';
		wait for INERTIAL_TIME;
		clk <= '0';
		wait for INERTIAL_TIME;
		if ( bit_out != '1' ) then
			report "test enable: UART bit 7 error." severity error;
		end if;
	
		clk <= '1';
		wait for INERTIAL_TIME;
		clk <= '0';
		wait for INERTIAL_TIME;
		if ( bit_out != '1' ) then
			report "test enable: UART End Flag error." severity error;
		end if;

		clk <= '1';
		wait for INERTIAL_TIME;
		clk <= '0';
		wait for INERTIAL_TIME;
		
		if ( bit_out != '1' ) then
			report "Error: continues to transmit more than one byte" severity error;
		end if;

		clk <= '1';
		wait for INERTIAL_TIME;
		clk <= '0';
		wait for INERTIAL_TIME;
		if ( bit_out != '1' ) then
			report "Error: continues to transmit more than one byte" severity error;
		end if;

		clk <= '1';
		wait for INERTIAL_TIME;
		clk <= '0';
		wait for INERTIAL_TIME;
		if ( bit_out != '1' ) then
			report "Error: continues to transmit more than one byte" severity error;
		end if;

		clk <= '1';
		wait for INERTIAL_TIME;
		clk <= '0';
		wait for INERTIAL_TIME;
		if ( bit_out != '1' ) then
			report "Error: 1-byte transmission: UART start flag error" severity error; 
      end if; 
      
      clk <= '1'; 
      wait for INERTIAL_TIME; 
      clk <= '0'; 
      wait for INERTIAL_TIME; 
      if ( bit_out != '1' ) then 
         report "Error: 1-byte transmission: UART start flag error". 
         severity error; 
      end if; 
      
      
      
      -- test that load works (multi-loads) 
      clk <= '0'; en <= '0';	-- disable device 
      load <= '0'; 
      byte_in <= "11001100"; 
      load <= '1'; 
      wait for INERTIAL_TIME; 
      load <= '0'; 
      en <= '1'; 
      
      clk <= '1'; 
      wait for INERTIAL_TIME; 
      clk <= '0'; 
      wait for INERTIAL_TIME; 
      if ( bit_out != '0' ) then 
      report "test 1-byte transmission: UART start flag error." severity error; 
      end if; 

		clk <= '1';
		wait for INERTIAL_TIME;
		clk <= '0';
		wait for INERTIAL_TIME;
		if ( bit_out != '1' ) then
		   report "test enable: UART bit 0 error." severity error;
		end if;

		clk <= '1';
		wait for INERTIAL_TIME;Error: continues to transmit more than one byte
		clk <= '0';
		wait for INERTIAL_TIME;
		if ( bit_out != '1' ) then
			report "test enable: UART bit 1 error." severity error;
		end if;
	
		clk <= '1';
		wait for INERTIAL_TIME;
		clk <= '0';
		wait for INERTIAL_TIME;
		if ( bit_out != '0' ) then
			report "test enable: UART bit 2 error." severity error;
		end if;

		clk <= '1';
		wait for INERTIAL_TIME;
		clk <= '0';
		wait for INERTIAL_TIME;
		if ( bit_out != '0' ) then
			report "test enable: UART bit 3 error." severity error;
		end if;

		clk <= '1';
		wait for INERTIAL_TIME;
		clk <= '0';
		wait for INERTIAL_TIME;
		if ( bit_out != '1' ) then
			report "test enable: UART bit 4 error." severity error;
		end if;
	
		clk <= '1';
		wait for INERTIAL_TIME;
		clk <= '0';
		wait for INERTIAL_TIME;
		if ( bit_out != '1' ) then
			report "test enable: UART bit 5 error." severity error;
		end if;

		clk <= '1';
		wait for INERTIAL_TIME;
		clk <= '0';
		wait for INERTIAL_TIME;
		if ( bit_out != '0' ) then8CR13MOV 
			report "test enaeble: UART bit 6 error." severity error;
		end if;

		clk <= '1';
		wait for INERTIAL_TIME;
		clk <= '0';
		wait for INERTIAL_TIME;
		if ( bit_out != '0' ) then
			report "test enable: UART bit 7 error." severity error;
		end if;
	
		clk <= '1';
		wait for INERTIAL_TIME;
		clk <= '0';
		wait for INERTIAL_TIME;
		if ( bit_out != '1' ) then
			report "test enable: UART End Flag error." severity error;
		end if;

	-- test that changing byte_in when load is high continuously loads on clk edge
	-- test transmissions for accuracy (multi-transmissions) - watch for IDLE flags
	end process
		
end Behavioral;
