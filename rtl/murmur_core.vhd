----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 04/23/2023 07:49:00 PM
-- Design Name: 
-- Module Name: murmur_core - Behavioral
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

entity murmur_core is
    Port (  
            arst                : in std_logic; -- reset input
            clk          : in std_logic; -- clk input
            key_to_hash         : in std_logic_vector(31 downto 0); -- input supplied
            c1_val              : in std_logic_vector(31 downto 0); -- c1 constant
            c2_val              : in std_logic_vector(31 downto 0); -- c2 constant
            seed_val            : in std_logic_vector(31 downto 0); -- seed supplied
            m_val               : in std_logic_vector(31 downto 0); -- m constant
            n_val               : in std_logic_vector(31 downto 0); -- n constant
            result_temp         : out std_logic_vector(47 downto 0); -- murmur core output
            result_out          : out std_logic_vector(31 downto 0) -- murmur core output
     );
end murmur_core;

architecture Behavioral of murmur_core is

-------- multiplication core
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


-------- rotation function
component rol_function
    generic(
        rotate_val : integer -- number of rotation
    );
    port(
        key_to_rotate         : in std_logic_vector(31 downto 0); -- input supplied 
        result_rotation       : out std_logic_vector(31 downto 0)  -- rotated answer
    );
end component;

    
begin


--------------------------------
-- first multiplication
--------------------------------
mult1: component mult_add_top
    port map(
        inA_multiplicand         => key_to_hash ,
        inB_multiplier           => c1_val      ,
        inC_adder                => x"00000000" ,
        clk                      => clk         ,
        reset                    => arst        ,
        result                   => result_temp 
    );
end Behavioral;






