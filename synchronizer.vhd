
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;
use IEEE.std_logic_unsigned.all;

LIBRARY altera;
USE altera.altera_primitives_components.all;


entity synchronizer is
  generic (
    RESET_VALUE    : std_logic := '0'
  );
  port(
		rst      : in std_logic; -- asynchronous, high-active
		clk 		: in std_logic;
		input  	: in std_logic;
		output 	: out std_logic
  );
end synchronizer;


architecture sync of synchronizer is

signal mid : std_logic := RESET_VALUE;

begin

	synchronizer: process(clk, rst)
		begin
			if rst = '1' then
				mid <= RESET_VALUE;
				output <= RESET_VALUE;
			elsif rising_edge(clk) then
				mid <= input;
				output <= mid;
			end if;
		end process;
end architecture sync;

		