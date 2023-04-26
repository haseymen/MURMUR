----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 04/26/2023 11:01:22 PM
-- Design Name: 
-- Module Name: rs_function - Behavioral
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

entity rs_function is
    Generic(
        rshift_val : integer:= 0 -- number of rotation
    );
    Port(
        key_to_rshift         : in std_logic_vector(31 downto 0); -- input supplied
        result_rshift       : out std_logic_vector(31 downto 0)  -- rotated answer
    );
end rs_function;

architecture Behavioral of rs_function is

begin

    result_rshift(31-rshift_val downto 0) <= key_to_rshift(31 downto rshift_val);
    result_rshift(31 downto 32 - rshift_val) <= (others => '0');


end Behavioral;
