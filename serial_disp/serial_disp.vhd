library IEEE;
use IEEE.STD_LOGIC_1164.all;

entity serial_disp is
   Port (
      CLK      : in  STD_LOGIC;
      TRANSMIT : out STD_LOGIC;
		TEST : out STD_LOGIC;
		TEST2 : out STD_LOGIC;
		TEST3 : out STD_LOGIC
   );
end serial_disp;

architecture Structural of serial_disp is

   -- component declaration for the Baud Rate Generator
   component Baud_Gen 
      Port (
         Clk_In   : in  STD_LOGIC;
         Baud_Out : out STD_LOGIC
      );
   end component;

   -- component declaration for the ROM
   component ROM
      Port (
         EN   : in  STD_LOGIC;
         ADDR : in  STD_LOGIC_VECTOR ( 4 downto 0 );
         Data : out STD_LOGIC_VECTOR ( 7 downto 0 )
      );
   end component;

   -- component declaration for the UART module
   component UART_Reg
      Port (
         CLK      : in  STD_LOGIC;
         EN       : in  STD_LOGIC;
         LOAD     : in  STD_LOGIC;
         BYTE_IN  : in  STD_LOGIC_VECTOR ( 7 downto 0 );
         BIT_OUT  : out STD_LOGIC;
         IDLE     : out STD_LOGIC
      );
   end component;

   -- component declaration for the controller
   component Controller
      Port (
         CLK         : in  STD_LOGIC;
         UART_IDLE   : in  STD_LOGIC;
         ROM_ADDR    : out STD_LOGIC_VECTOR ( 4 downto 0 );
         UART_GO     : out STD_LOGIC;
         UART_LOAD   : out STD_LOGIC
      );
	end component;

   signal baud_clk   : STD_LOGIC;
   signal ROM_EN     : STD_LOGIC;
   signal ROM_ADDR   : STD_LOGIC_VECTOR ( 4 downto 0 );
   signal ROM_Data   : STD_LOGIC_VECTOR ( 7 downto 0 );
   signal UART_EN    : STD_LOGIC;
   signal UART_LOAD  : STD_LOGIC;
   signal UART_IDLE  : STD_LOGIC;
	
	signal TRANS_TRANSMIT : STD_LOGIC;

begin

   Baud_Rate_Generator : Baud_Gen port map (
      Clk_in      => CLK,
      Baud_Out    => baud_clk
   );

   Character_ROM : ROM port map (
      EN          => '1',
      ADDR        => ROM_ADDR,
      Data        => ROM_Data
   );

   UART_Module : UART_Reg port map (
      CLK         => baud_clk,
      EN          => UART_EN,
      LOAD        => UART_LOAD,
      BYTE_IN     => ROM_Data,
      BIT_OUT     => TRANS_TRANSMIT,
      IDLE        => UART_IDLE
   );

   Main_Controller : Controller port map (
      CLK         => baud_clk,
      UART_IDLE   => UART_IDLE,
      ROM_ADDR    => ROM_ADDR,
      UART_GO		=> UART_EN,
      UART_LOAD   => UART_LOAD
   );
	
	CLOCK_SLOW : Baud_Gen port map (
		Clk_in     => baud_clk,
		Baud_Out   => TEST2
	);
	TEST <= baud_clk;
	TEST3 <= TRANS_TRANSMIT;
	TRANSMIT <= TRANS_TRANSMIT;

end Structural;
