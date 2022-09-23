
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;
use IEEE.std_logic_unsigned.all;

LIBRARY altera;
USE altera.altera_primitives_components.all;


entity conditioner is
  generic (
    RESET_VALUE    : std_logic := '0'
  );
  port(
		rst      : in std_logic; 
		clk 		: in std_logic;
		input  	: in std_logic;
		output 	: out std_logic
  );
end conditioner;


architecture cond of conditioner is

signal out_vector	: std_logic_vector(1 downto 0) := "00";

begin



				sync1 : entity work.synchronizer
					port map (
						clk => clk,
						rst => rst,
						input => input,
						output => out_vector(0)
					);
		
				deb1 : entity work.debouncer
					port map (
						clk => clk,
						rst => rst,
						input => out_vector(0),
						output => out_vector(1)
					);
	
				op1 : entity work.onepulse
					port map (
						clk => clk,
						rst => rst,
						input => out_vector(1),
						output => output
					);
					
			
				
end architecture cond;

		