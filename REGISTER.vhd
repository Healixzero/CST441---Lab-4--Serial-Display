use IEEE.STD_LOGIC_1164.all;

package REGISTER is
   component bytereg
      port (
         clk    : in  STD_LOGIC;
         input  : in  STD_LOGIC_VECTOR ( 7 downto 0 );
         load   : in  STD_LOGIC;
         en     : in  STD_LOGIC;
         output : out STD_LOGIC;
      );
   end component;

   component bitreg
      port ( 
         clk    : in  STD_LOGIC;
         input  : in  STD_LOGIC;
         load   : in  STD_LOGIC;
         en     : in  STD_LOGIC;
         output : out STD_LOGIC;
      );
   end component;

end REGISTER;


