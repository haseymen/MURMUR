----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 04/26/2023 11:44:18 PM
-- Design Name: 
-- Module Name: murmur_top - Behavioral
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

entity murmur_top is
    Port (  
            arst                : in std_logic; -- reset input
            clk                 : in std_logic; -- clk input
            key_to_hash         : in std_logic_vector(31 downto 0); -- input supplied
            c1_val              : in std_logic_vector(31 downto 0); -- c1 constant
            c2_val              : in std_logic_vector(31 downto 0); -- c2 constant
            seed_val            : in std_logic_vector(31 downto 0); -- seed supplied
            m_val               : in std_logic_vector(31 downto 0); -- m constant
            n_val               : in std_logic_vector(31 downto 0); -- n constant
            x_val               : in std_logic_vector(31 downto 0); -- c1 constant
            y_val               : in std_logic_vector(31 downto 0); -- c2 constant
            len                 : in std_logic_vector(31 downto 0); -- c2 constant
            result_hash         : out std_logic_vector(31 downto 0) -- murmur core output
     );
end murmur_top;
   


architecture Behavioral of murmur_top is

------------------------------------------------------------------------------------ signal declerations
signal result_temp             :std_logic_vector(31 downto 0):=(others=>'0');

------------------------------------------------------------------------------------ murmur core component architecture
component murmur_core
    Port (  
            arst                : in std_logic; -- reset input
            clk          : in std_logic; -- clk input
            key_to_hash         : in std_logic_vector(31 downto 0); -- input supplied
            c1_val              : in std_logic_vector(31 downto 0); -- c1 constant
            c2_val              : in std_logic_vector(31 downto 0); -- c2 constant
            seed_val            : in std_logic_vector(31 downto 0); -- seed supplied
            m_val               : in std_logic_vector(31 downto 0); -- m constant
            n_val               : in std_logic_vector(31 downto 0); -- n constant
            result_out          : out std_logic_vector(31 downto 0) -- murmur core output
     );
end component;


------------------------------------------------------------------------------------ murmur core component architecture
component murmur_finalize
    Port (
        arst                            : in std_logic; -- reset input
        clk                             : in std_logic; -- clk input
        val_to_finalize                 : in std_logic_vector(31 downto 0); -- input supplied
        x_val                           : in std_logic_vector(31 downto 0); -- c1 constant
        y_val                           : in std_logic_vector(31 downto 0); -- c2 constant
        len                             : in std_logic_vector(31 downto 0); -- c2 constant
        result_out                      : out std_logic_vector(31 downto 0) -- murmur core output
    );
end component;

begin

------------------------------------------------------------------------------------ 
-- first murmur core
------------------------------------------------------------------------------------
murmur_core1 : component murmur_core 
    port map(
        arst            => arst        ,
        clk             => clk         ,
        key_to_hash     => key_to_hash ,
        c1_val          => c1_val      ,
        c2_val          => c2_val      ,
        seed_val        => seed_val    ,
        m_val           => m_val       ,
        n_val           => n_val       ,
        result_out      => result_temp           
    );


------------------------------------------------------------------------------------ 
-- first murmur_finalize
------------------------------------------------------------------------------------
murmur_finalize1 : component murmur_finalize 
    port map(           
        arst            => arst        ,
        clk             => clk         ,
        val_to_finalize => result_temp ,
        x_val           => x_val       ,     
        y_val           => y_val       ,     
        len             => len         ,     
        result_out      => result_hash       
    );

end Behavioral;
