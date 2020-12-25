----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 12/25/2020 11:18:54 PM
-- Design Name: 
-- Module Name: CLK_DIVIDER - Behavioral
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

entity CLK_DIVIDER is
  Port ( CLK_IN : IN STD_LOGIC;
         CLK_OUT: OUT STD_LOGIC
         );
end CLK_DIVIDER;

architecture Behavioral of CLK_DIVIDER is
SIGNAL CLK_50 : STD_LOGIC := '0';
SIGNAL CLK_25 : STD_LOGIC := '0';
begin
    CLK_50Mhz_div :Process (CLK_IN)
        BEGIN
            IF RISING_EDGE(CLK_IN) THEN
                CLK_50<= NOT CLK_50;
            END IF;
        END PROCESS;
    CLK_25MHz_DIV: PROCESS (CLK_50)
        BEGIN
            IF RISING_EDGE(CLK_50) THEN
                CLK_25<= NOT CLK_25;
            END IF;
                
        END PROCESS;
    CLK_OUT <= CLK_25;

end Behavioral;
