library IEEE
use IEEE.STD_LOGIC_1164.all

entity UART_Reg is
   Port ( 
      CLK      : in  STD_LOGIC;  -- expecting a legitimate baud signal
      EN       : in  STD_LOGIC;  -- Enable must be held high, always transmits from the beginning
      LOAD     : in  STD_LOGIC;  -- Load data into the buffer from BYTE_IN, dont set high when EN is high
      BYTE_IN  : in  STD_LOGIC_VECTOR ( 7 downto 0 ); -- the data that should be transmitted
      BIT_OUT  : out STD_LOGIC;  -- 
      IDLE     : out STD_LOGIC
   );
end UART_Reg;

architecture Behavioural of UART_Reg is

   -- signals & variables go here
   variable state : integer;  -- controls the state, should have values 0-10.
   signal   buff  : STD_LOGIC_VECTOR ( 7 downto 0 );

begin

   -- state machine counter 
      -- S0  : IDLE      output = 1 (not end bit)
      -- S1  : Start bit: output = 0
      -- S2  : Data bit 0
      -- S3  : Data bit 1
      -- S4  : Data bit 2
      -- S5  : Data bit 3
      -- S6  : Data bit 4
      -- S7  : Data bit 5
      -- S8  : Data bit 6
      -- S9  : Data bit 7
      -- S10 : End bit: output = 1

   State_Counter: Process ( CLK, state ) -- counter should count between 0 and 10.
   begin
      -- reset to IDLE state unless ENABLE is '1' and the state is S1-S10, and its
      --    the rising edge of the CLK signal
      if ( CLK 'event and CLK = '1' and state < 10 and state > 0 and EN = '1' ) then
         state = ( state + 1 );
      else
         state = 0;  -- if out of bounds, reset to IDLE state
      end if;
   end process;

   -- Determine what bit to output on the BIT_OUT line
   State_Control: Process ( state ) 
   begin
      case State is
         when     1  => BIT_OUT <= '0';      -- Start bit
         when     2  => BIT_OUT <= buff[0];  -- Data bit 1
         when     3  => BIT_OUT <= buff[1];  -- Data bit 2
         when     4  => BIT_OUT <= buff[2];  -- Data bit 3
         when     5  => BIT_OUT <= buff[3];  -- Data bit 4
         when     6  => BIT_OUT <= buff[4];  -- Data bit 5
         when     7  => BIT_OUT <= buff[5];  -- Data bit 6
         when     8  => BIT_OUT <= buff[6];  -- Data bit 7
         when     9  => BIT_OUT <= buff[7];  -- Data bit 8
         when     10 => BIT_OUT <= '1';      -- End bit
         when others => BIT_OUT <= '1';      -- Pseudo end-bit
   end Process

   -- on LOAD = 1, load data from BYTE_IN into the buffer (buff)
   Load_Control: Process ( Load )
   begin
      if ( Load = '1' )
         buff[0] <= BYTE_IN[0];  -- Data bit 0
         buff[1] <= BYTE_IN[1];  -- Data bit 1
         buff[2] <= BYTE_IN[2];  -- Data bit 2
         buff[3] <= BYTE_IN[3];  -- Data bit 3
         buff[4] <= BYTE_IN[4];  -- Data bit 4
         buff[5] <= BYTE_IN[5];  -- Data bit 5
         buff[6] <= BYTE_IN[6];  -- Data bit 6
         buff[7] <= BYTE_IN[7];  -- Data bit 7
   end Process;

   -- Determine value of IDLE signal
   if ( state = 0 ) then
      IDLE = '1';
   else
      IDLE = '0';
   end if;

end Behavioural;

