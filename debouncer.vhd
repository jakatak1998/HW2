
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;
use IEEE.std_logic_unsigned.all;

LIBRARY altera;
USE altera.altera_primitives_components.all;


entity debouncer is
  generic (
    RESET_VALUE    : std_logic := '0';
	 TIME_DELAY		 : std_logic_vector(23 downto 0) := X"400000"
  );
  port(
		rst      : in std_logic; -- asynchronous, high-active
		clk 		: in std_logic;
		input  	: in std_logic;
		output 	: out std_logic
  );
end debouncer;


architecture deb of debouncer is

signal counter : std_logic_vector(23 downto 0) := X"000000";
signal state 	: std_logic_vector(1 downto 0) := "00";

begin

	debouncer: process(clk, rst)
		begin
			if (rst = '1') then
				counter 	<= X"000000";
				output 	<= RESET_VALUE;
				state 	<= "00";
			elsif rising_edge(clk) then

				case state is
					when "00" =>
						if input = '1' then 
							state <= "01";
						end if;
					when "01" =>
						if (counter < TIME_DELAY) then 
							counter <= counter + '1';
						else 
							state <= "10";
							output <= '1';
						end if;
					when "10" =>
						if input = '0' then
							state <= "00";
							output <= '0';
						end if;
					when others => null;
				end case;
				
			end if;
		end process;
end architecture deb;

		