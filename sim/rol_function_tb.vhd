----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 04/25/2023 10:10:53 PM
-- Design Name: 
-- Module Name: rol_function_tb - Behavioral
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

entity rol_function_tb is
--  Port ( );
end rol_function_tb;

architecture Behavioral of rol_function_tb is


------------------------------------------------------------------------------------ signal declerations
signal key_to_rotate     : STD_LOGIC_VECTOR (31 downto 0):= x"8000a000";
signal result_temp     : STD_LOGIC_VECTOR (31 downto 0);

------------------------------------------------------------------------------------ rotation function
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

DUT: rol_function 
    generic map(
        rotate_val => 15
    )
    port map(
        key_to_rotate        => key_to_rotate,
        result_rotation      => result_temp
    );


end Behavioral;
