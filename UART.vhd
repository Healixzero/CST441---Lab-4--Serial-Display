library IEEE;
use iEEE.STD_LOGIC_1164.all;

entity uarttx is 
   port (
      clk    : in  STD_LOGIC;
      data   : in  STD_LOGIC_VECTOR ( 7 downto 0 );
      ready  : in  STD_LOGIC;
      idle   : out STD_LOGIC;
      output : out STD_LOGIC;
      );
end uarttx;

architecture struct of uarttx is
component bytereg is
   Port (
      clk        : in  STD_LOGIC;
      byte_input : in  STD_LOGIC_VECTOR ( 7 downto 0 );
      load       : in  STD_LOGIC;
      en         : in  STD_LOGIC;
      output     : out STD_LOGIC;
   );
end component;


component bitreg is
   Port (
      clk

