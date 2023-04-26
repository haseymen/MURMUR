----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 04/26/2023 10:56:46 PM
-- Design Name: 
-- Module Name: murmur_finalize - Behavioral
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

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity murmur_finalize is
    Port (
        arst                            : in std_logic; -- reset input
        clk                             : in std_logic; -- clk input
        val_to_finalize                 : in std_logic_vector(31 downto 0); -- input supplied
        x_val                           : in std_logic_vector(31 downto 0); -- c1 constant
        y_val                           : in std_logic_vector(31 downto 0); -- c2 constant
        len                             : in std_logic_vector(31 downto 0); -- c2 constant
        result_out                      : out std_logic_vector(31 downto 0) -- murmur core output
    );
end murmur_finalize;

architecture Behavioral of murmur_finalize is

------------------------------------------------------------------------------------ signal declerations
signal result_mult1             :std_logic_vector(47 downto 0):=(others=>'0');
signal result_mult2             :std_logic_vector(47 downto 0):=(others=>'0');
signal result_xor1              :std_logic_vector(31 downto 0):=(others=>'0');
signal result_xor2              :std_logic_vector(31 downto 0):=(others=>'0');
signal result_xor3              :std_logic_vector(31 downto 0):=(others=>'0');
signal result_xor4              :std_logic_vector(31 downto 0):=(others=>'0');
signal result_rs16_1            :std_logic_vector(31 downto 0):=(others=>'0');
signal result_rs16_2            :std_logic_vector(31 downto 0):=(others=>'0');
signal result_rs13              :std_logic_vector(31 downto 0):=(others=>'0');


------------------------------------------------------------------------------------ multiplication core
component mult_add_top
    port( 
        inA_multiplicand         : in STD_LOGIC_VECTOR (31 downto 0);
        inB_multiplier           : in STD_LOGIC_VECTOR (31 downto 0);
        inC_adder                : in STD_LOGIC_VECTOR (31 downto 0);
        clk                      : in STD_LOGIC;
        reset                    : in STD_LOGIC;
        result                   : out STD_LOGIC_VECTOR (47 downto 0)
    );
end component;


------------------------------------------------------------------------------------ right disconnect core
component rs_function
    Generic(
        rshift_val : integer:= 0 -- number of rotation
    );
    Port(
        key_to_rshift         : in std_logic_vector(31 downto 0); -- input supplied
        result_rshift       : out std_logic_vector(31 downto 0)  -- rotated answer
    );
end component;

begin

------------------------------------------------------------------------------------ 
-- first xor
------------------------------------------------------------------------------------
result_xor1 <= val_to_finalize XOR len;


------------------------------------------------------------------------------------ 
-- first RS16
------------------------------------------------------------------------------------
rs16_1: component rs_function 
    generic map(
        rshift_val => 16
    )
    port map(
        key_to_rshift      => result_xor1,
        result_rshift      => result_rs16_1
    );


------------------------------------------------------------------------------------ 
-- second xor
------------------------------------------------------------------------------------
result_xor2 <= result_xor1 XOR result_rs16_1;


------------------------------------------------------------------------------------ 
-- first multiplication
------------------------------------------------------------------------------------ 
mult1: component mult_add_top
    port map(
        inA_multiplicand         => result_xor2 ,
        inB_multiplier           => x_val       ,
        inC_adder                => x"00000000" ,
        clk                      => clk         ,   
        reset                    => arst        ,
        result                   => result_mult1 
    );


------------------------------------------------------------------------------------ 
-- first RS13
------------------------------------------------------------------------------------
rs13: component rs_function 
    generic map(
        rshift_val => 13
    )
    port map(
        key_to_rshift      => result_mult1(31 downto 0),
        result_rshift      => result_rs13
    );


------------------------------------------------------------------------------------ 
-- third xor
------------------------------------------------------------------------------------
result_xor3 <= result_mult1(31 downto 0) XOR result_rs13;


------------------------------------------------------------------------------------ 
-- second multiplication
------------------------------------------------------------------------------------ 
mult2: component mult_add_top
    port map(
        inA_multiplicand         => result_xor3 ,
        inB_multiplier           => y_val       ,
        inC_adder                => x"00000000" ,
        clk                      => clk         ,   
        reset                    => arst        ,
        result                   => result_mult2 
    );


------------------------------------------------------------------------------------ 
-- second RS16
------------------------------------------------------------------------------------
rs16_2: component rs_function 
    generic map(
        rshift_val => 16
    )
    port map(
        key_to_rshift      => result_mult2(31 downto 0),
        result_rshift      => result_rs16_2
    );


------------------------------------------------------------------------------------ 
-- fourth xor
------------------------------------------------------------------------------------
result_out <= result_mult2(31 downto 0) XOR result_rs16_2;

end Behavioral;
