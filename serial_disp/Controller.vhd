----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    03:00:39 03/14/2012 
-- Design Name: 
-- Module Name:    Controller - Behavioral 
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

entity Controller is

   generic ( num_addr : integer := 14 );

    Port ( CLK       : in  STD_LOGIC;
           UART_IDLE : in  STD_LOGIC;
           ROM_ADDR  : out  STD_LOGIC_VECTOR (4 downto 0);
           UART_GO   : out  STD_LOGIC;
           UART_LOAD : out  STD_LOGIC);
end Controller;

architecture Behavioral of Controller is

   signal state   : integer := 0;
	signal ROM_buff: integer := 0;

   constant IDLE        : integer := 0;   -- wait for UART to be done transmitting
   constant LOAD        : integer := 1;   -- load in from ROM module
   constant TRANSMIT    : integer := 2;   -- UART transmits
   constant INCREMENT   : integer := 3;   -- while UART is transmitting, increment ROM pointer
   constant DONE        : integer := 4;   -- when you get here, all transmitting is done.
	
   -- converts an input STD_LOGIC_VECTOR to an int
	function TO_INT ( Data : STD_LOGIC_VECTOR ( 4 downto 0 ) )
		return integer is
		variable result : integer;
	begin
		case ( Data ) is 
			when "00000" => result := 0;
			when "00001" => result := 1;
			when "00010" => result := 2;
			when "00011" => result := 3;
			when "00100" => result := 4;
			when "00101" => result := 5;
			when "00110" => result := 6;
			when "00111" => result := 7;
			when "01000" => result := 8;
			when "01001" => result := 9;
			when "01010" => result := 10;
			when "01011" => result := 11;
			when "01100" => result := 12;
			when "01101" => result := 13;
			when "01110" => result := 14;
			when "01111" => result := 15;
			when "10000" => result := 16;
			when "10001" => result := 17;
			when "10010" => result := 18;
			when "10011" => result := 19;
			when "10100" => result := 20;
			when "10101" => result := 21;
			when "10110" => result := 22;
			when "10111" => result := 23;
			when "11000" => result := 24;
			when "11001" => result := 25;
			when "11010" => result := 26;
			when "11011" => result := 27;
			when "11100" => result := 28;
			when "11101" => result := 29;
			when "11110" => result := 30;
			when "11111" => result := 31;
			when others  => result := 0;
		end case;
		return result;
	end function;	

   -- converts a int to a STD_LOGIC_VECTOR
	function TO_STD_LOG_VEC ( Data : integer )
		return STD_LOGIC_VECTOR is
		variable result : STD_LOGIC_VECTOR ( 4 downto 0 );
	begin
		case ( Data ) is 
			when  0 => result := "00000";
			when  1 => result := "00001";
			when  2 => result := "00010";
			when  3 => result := "00011";
			when  4 => result := "00100";
			when  5 => result := "00101";
			when  6 => result := "00110";
			when  7 => result := "00111";
			when  8 => result := "01000";
			when  9 => result := "01001";
			when 10 => result := "01010";
			when 11 => result := "01011";
			when 12 => result := "01100";
			when 13 => result := "01101";
			when 14 => result := "01110";
			when 15 => result := "01111";
			when 16 => result := "10000";
			when 17 => result := "10001";
			when 18 => result := "10010";
			when 19 => result := "10011";
			when 20 => result := "10100";
			when 21 => result := "10101";
			when 22 => result := "10110";
			when 23 => result := "10111";
			when 24 => result := "11000";
			when 25 => result := "11001";
			when 26 => result := "11010";
			when 27 => result := "11011";
			when 28 => result := "11100";
			when 29 => result := "11101";
			when 30 => result := "11110";
			when 31 => result := "11111";
			when others  => result := "00000";
		end case;
		return result;
	end function;

begin

   State_Controller : process ( CLK, UART_IDLE )
   begin

      if ( CLK'event and CLK = '1' ) then
         case state is
            when IDLE =>   -- waiting for UART To be idle
               ROM_buff    <= ROM_buff;
               UART_LOAD   <= '0';
               UART_GO     <= '0';
               if ( UART_IDLE = '1' ) then
                  state <= LOAD;
               else
                  state <= IDLE;
               end if;
            when LOAD =>   -- load data in from ROM
               ROM_buff    <= ROM_buff;
               if ( ROM_buff < num_addr ) then
                  UART_LOAD   <= '1';
               else
                  UART_LOAD   <= '0';
               end if;
               UART_GO     <= '0';
               state <= TRANSMIT;
            when TRANSMIT =>  -- UART start transmitting
               ROM_buff <= ROM_buff;
               UART_LOAD   <= '0';
               if ( ROM_buff < num_addr ) then
                  UART_GO  <= '1';
               else
                  UART_GO  <= '0';
               end if;
               state <= INCREMENT;
            when INCREMENT => -- while UART transmits, increment pointer
               if ( ROM_buff < num_addr ) then
                  ROM_buff <= ( ROM_buff + 1 );
                  state <= IDLE;
               else
                  ROM_buff <= ROM_Buff;
                  state <= DONE;
               end if;
               UART_LOAD   <= '0';
               UART_GO     <= '0';
            when DONE =>   -- when you get here, all data was sent
               ROM_buff    <= ROM_buff;
               UART_LOAD   <= '0';
               UART_GO     <= '0';
               state       <= DONE;
				when others => -- uh-oh....404, youre not found.
					ROM_buff		<= 0;
					UART_LOAD	<= '0';
					UART_GO 		<= '0';
					state <= 0;
         end case;
      end if;
   end process;

   -- convert buffer value to a STD_LOGIC_VECTOR and send to output
	ROM_ADDR <= TO_STD_LOG_VEC ( ROM_buff );

end Behavioral;

