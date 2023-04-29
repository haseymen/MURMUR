----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 04/28/2023 09:38:10 PM
-- Design Name: 
-- Module Name: murmur_top_tb - Behavioral
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

entity murmur_top_tb is
--  Port ( );
end murmur_top_tb;

architecture Behavioral of murmur_top_tb is

signal arst                       :std_logic;
signal clk                        :std_logic;
signal key_to_hash                :std_logic_vector(31 downto 0):=(others=>'0');
signal c1_val                     :std_logic_vector(31 downto 0):=(others=>'0');
signal c2_val                     :std_logic_vector(31 downto 0):=(others=>'0');
signal seed_val                   :std_logic_vector(31 downto 0):=(others=>'0');
signal m_val                      :std_logic_vector(31 downto 0):=(others=>'0');
signal n_val                      :std_logic_vector(31 downto 0):=(others=>'0');
signal x_val                      :std_logic_vector(31 downto 0):=(others=>'0');
signal y_val                      :std_logic_vector(31 downto 0):=(others=>'0');
signal len                        :std_logic_vector(31 downto 0):=(others=>'0');
signal result_hash                :std_logic_vector(31 downto 0):=(others=>'0');
constant clock_period : time := 10 ns;




component murmur_top
    port(
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
end component;


begin

-- Clock process definitions
clock_process :process
begin
clk <= '0';
wait for clock_period/2;
clk <= '1';
wait for clock_period/2;
end process;


DUT: murmur_top
    port map(
        arst            =>     arst          , 
        clk             =>     clk           , 
        key_to_hash     =>     key_to_hash   , 
        c1_val          =>     c1_val        , 
        c2_val          =>     c2_val        , 
        seed_val        =>     seed_val      , 
        m_val           =>     m_val         , 
        n_val           =>     n_val         , 
        x_val           =>     x_val         , 
        y_val           =>     y_val         , 
        len             =>     len           , 
        result_hash     =>     result_hash    
    );



------------------------------------------
stimulus: process
begin
arst <= '1';
key_to_hash <= x"00000000";
c1_val      <= x"00000000";
c2_val      <= x"00000000";
seed_val    <= x"00000000";
m_val       <= x"00000000";
n_val       <= x"00000000";
x_val       <= x"00000000";
y_val       <= x"00000000";
len         <= x"00000000";

wait for 50ns;

arst <= '0';
key_to_hash <= x"00ff0aff";
c1_val      <= x"cc9e2d51";
c2_val      <= x"1b873593";
seed_val    <= x"00000000";
m_val       <= x"e6546b64";
n_val       <= x"00000005";
x_val       <= x"85ebca6b";
y_val       <= x"c2b2ae35";
len         <= x"00000004";

wait for 200ns;
assert false report "Test: OK" severity failure;
end process;



end Behavioral;
