----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 03/26/2023 05:44:06 PM
-- Design Name: 
-- Module Name: single_mult - Behavioral
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
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
use IEEE.numeric_std.all;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity mult_add_top is
    Port ( inA_multiplicand         : in STD_LOGIC_VECTOR (31 downto 0);
           inB_multiplier           : in STD_LOGIC_VECTOR (31 downto 0);
           inC_adder                : in STD_LOGIC_VECTOR (31 downto 0);
           clk                      : in STD_LOGIC;
           reset                    : in STD_LOGIC;
           result                   : out STD_LOGIC_VECTOR (47 downto 0)
           );
end mult_add_top;

architecture Behavioral of mult_add_top is

signal result_00                    : std_logic_vector(47 downto 0);
signal result_00_empty              : std_logic_vector(47 downto 0);
signal result_01                    : std_logic_vector(47 downto 0);
signal result_01_empty              : std_logic_vector(47 downto 0);
signal result_11_empty              : std_logic_vector(47 downto 0);
signal concat_empty                 : std_logic_vector(47 downto 0);
signal result_10                    : std_logic_vector(47 downto 0);
signal result_11                    : std_logic_vector(47 downto 0);


COMPONENT dsp_macro_0
  PORT (
    CLK : IN STD_LOGIC;
    A : IN STD_LOGIC_VECTOR(16 DOWNTO 0);
    B : IN STD_LOGIC_VECTOR(16 DOWNTO 0);
    C : IN STD_LOGIC_VECTOR(32 DOWNTO 0);
    PCOUT : OUT STD_LOGIC_VECTOR(47 DOWNTO 0);
    P : OUT STD_LOGIC_VECTOR(47 DOWNTO 0) 
  );
END COMPONENT;

COMPONENT dsp_macro_1
  PORT (
    CLK : IN STD_LOGIC;
    A : IN STD_LOGIC_VECTOR(15 DOWNTO 0);
    B : IN STD_LOGIC_VECTOR(15 DOWNTO 0);
    --C : IN STD_LOGIC_VECTOR(32 DOWNTO 0);
    --PCOUT : OUT STD_LOGIC_VECTOR(47 DOWNTO 0);
    P : OUT STD_LOGIC_VECTOR(47 DOWNTO 0) 
  );
END COMPONENT;

COMPONENT adder_dsp
  PORT (
    --CLK : IN STD_LOGIC;
    PCIN : IN STD_LOGIC_VECTOR(47 DOWNTO 0);
    C : IN STD_LOGIC_VECTOR(47 DOWNTO 0);
    CONCAT : IN STD_LOGIC_VECTOR(47 DOWNTO 0);
    P : OUT STD_LOGIC_VECTOR(47 DOWNTO 0) 
  );
END COMPONENT;

begin


multAlBl : dsp_macro_0
  PORT MAP (
    CLK => CLK,
    A => b"0" & inA_multiplicand(15 downto 0),
    B => b"0" & inB_multiplier(15 downto 0),
    C => b"0" & inC_adder,
    PCOUT => result_00,
    P => result_00_empty
  );
  

multAhBl : dsp_macro_1
  PORT MAP (
    CLK => CLK,
    A => inA_multiplicand(31 downto 16),
    B => inB_multiplier(15 downto 0),
    --C => x"00000000",
    P => result_01
  );

multAlBh : dsp_macro_1
  PORT MAP (
    CLK => CLK,
    A => inA_multiplicand(15 downto 0),
    B => inB_multiplier(31 downto 16),
    --C => x"00000000",
    P => result_10
  ); 

 --result <= std_logic_vector(unsigned(result_00) + unsigned(result_01(15 downto 0) & x"0000") + unsigned(result_10(15 downto 0) & x"0000"));

adderResult : adder_dsp
  PORT MAP (
    --CLK => CLK,
    PCIN => result_00,
    C =>  x"0000" & result_01(15 downto 0) & x"0000",
    CONCAT => x"0000" & result_10(15 downto 0) & x"0000",
    P => result
  );

end Behavioral;
