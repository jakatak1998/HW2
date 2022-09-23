
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;
use IEEE.std_logic_unsigned.all;

LIBRARY altera;
USE altera.altera_primitives_components.all;


entity onepulse is
  generic (
    RESET_VALUE    : std_logic := '0'
  );
  port(
		rst      : in std_logic; -- asynchronous, high-active
		clk 		: in std_logic;
		input  	: in std_logic;
		output 	: out std_logic
  );
end onepulse;


architecture op of onepulse is

signal state 	: std_logic := '0';

begin

	debouncer: process(clk, rst)
		begin
			if (rst = '1') then
				output 	<= RESET_VALUE;
				state 	<= '0';
			elsif rising_edge(clk) then

				case state is
					when '0' =>
						if input = '1' then
							output <= '1';
							state <= '1';
						end if;
					when '1' =>
						output <= '0';
						if input = '0' then
							state <= '0';
						end if;
					when others => null;
				end case;
				
			end if;
		end process;
end architecture op;

		