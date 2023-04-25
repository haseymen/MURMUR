----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 04/25/2023 09:21:29 PM
-- Design Name: 
-- Module Name: rol_function - Behavioral
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

entity rol_function is
    Generic(
        rotate_val : integer:= 0 -- number of rotation
    );
    Port(
        key_to_rotate         : in std_logic_vector(31 downto 0); -- input supplied
        result_rotation       : out std_logic_vector(31 downto 0)  -- rotated answer
    );
end rol_function;

architecture Behavioral of rol_function is

begin

    result_rotation <= key_to_rotate((31 - rotate_val) downto 0) & key_to_rotate(31 downto (32 - rotate_val));

end Behavioral;
