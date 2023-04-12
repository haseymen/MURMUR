
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;


entity mult_add_tb is
--  Port ( );
end mult_add_tb;

architecture Behavioral of mult_add_tb is

component mult_add_top is
    Port ( 
		inA_multiplicand         : in STD_LOGIC_VECTOR (31 downto 0);
		inB_multiplier           : in STD_LOGIC_VECTOR (31 downto 0);
		inC_adder                : in STD_LOGIC_VECTOR (31 downto 0);
		in_D                     : in STD_LOGIC_VECTOR (31 downto 0);
		clk                      : in STD_LOGIC;
		reset                    : in STD_LOGIC;
		result                   : out STD_LOGIC_VECTOR (47 downto 0)
           );
end component;

signal inA_multiplicand 			: STD_LOGIC_VECTOR (31 downto 0):= (others => '0');
signal inB_multiplier 				: STD_LOGIC_VECTOR (31 downto 0):= (others => '0');
signal inC_adder 					: STD_LOGIC_VECTOR (31 downto 0):= (others => '0');
signal in_D 						: STD_LOGIC_VECTOR (31 downto 0):= (others => '0');
signal clk 							: STD_LOGIC:= '0';                 
signal reset 						: STD_LOGIC:= '0';                
signal result 						: STD_LOGIC_VECTOR (47 downto 0);

begin

DUT: mult_add_top
    port map ( 
	   inA_multiplicand 			=>	inA_multiplicand 	,
	   inB_multiplier 				=>  inB_multiplier 	,
	   inC_adder 					=>  inC_adder 	,
	   in_D 						=>  in_D 	,
	   clk 							=>  clk 	,	
	   reset 						=>  reset   ,
	   result 						=>  result  
           );

	clk <= not clk after 4 ns; 
    reset <= '1'  after 4 ns;
	
deneme: process begin
--	inA_multiplicand <= x"AABBCCDD";
--	inB_multiplier <= x"EEFFAABB";
--	inC_adder <= x"CCCCDABE";
	inA_multiplicand <= x"aaaaaaaa";
	inB_multiplier <= x"bbbbbbbb";
	inC_adder <= x"cccccccc";



wait for 100ns;
report "SIM DONE"
severity failure;

end process;

end Behavioral;
