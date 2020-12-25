
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
USE IEEE.STD_LOGIC_UNSIGNED.ALL;
USE IEEE.STD_LOGIC_ARITH.ALL;

LIBRARY WORK;
USE WORK.VGA_SETTINGS.ALL;


entity VGA_RGB is
  Port (
        CLK_IN : IN STD_LOGIC;
         H_SYNC : OUT STD_LOGIC;
         V_SYNC : OUT STD_LOGIC;
         RED : OUT STD_LOGIC_VECTOR ( RED_WIDTH -1 DOWNTO 0);
         GREEN : OUT STD_LOGIC_VECTOR ( GREEN_WIDTH -1 DOWNTO 0);
         BLUE : OUT STD_LOGIC_VECTOR ( BLUE_WIDTH -1 DOWNTO 0)
          );
end VGA_RGB;

architecture Behavioral of VGA_RGB is

COMPONENT CLK_DIVIDER IS
    Port ( CLK_IN : IN STD_LOGIC;
         CLK_OUT: OUT STD_LOGIC
         );
 END COMPONENT;
 
 COMPONENT VGA_COUNTER IS
   Port (
       CLK_IN : IN STD_LOGIC;
       H_SYNC : OUT STD_LOGIC;
       V_SYNC : OUT STD_LOGIC;
       ----- PIXELS POSITION ---
       H_COUNT : OUT STD_LOGIC_VECTOR ( H_COUNT_WIDTH -1 DOWNTO 0);
       V_COUNT : OUT STD_LOGIC_VECTOR ( V_COUNT_WIDTH -1 DOWNTO 0);
       ---- ACTIVE AREA -------
       VIDEO_EN : OUT STD_LOGIC);
END COMPONENT;

SIGNAL CLK_DIV : STD_LOGIC;
SIGNAL VIDEO_EN : STD_LOGIC;
SIGNAL H_COUNT : STD_LOGIC_VECTOR ( H_COUNT_WIDTH -1 DOWNTO 0);
SIGNAL V_COUNT : STD_LOGIC_VECTOR ( V_COUNT_WIDTH -1 DOWNTO 0);

begin
    UUT_CLK : CLK_DIVIDER PORT MAP (
                CLK_IN => CLK_IN,
                CLK_OUT => CLK_DIV
            );
    UUT_COUNTER : VGA_COUNTER PORT MAP (
                CLK_IN => CLK_DIV,
                H_SYNC => H_SYNC,
                V_SYNC => V_SYNC,
                H_COUNT => H_COUNT,
                V_COUNT => V_COUNT,
                VIDEO_EN => VIDEO_EN
            );
    TEST: PROCESS( H_COUNT, V_COUNT)
            BEGIN
            IF VIDEO_EN = '1' THEN
                RED <= (OTHERS =>'0');
                GREEN <= (OTHERS =>'1');
                BLUE <= (OTHERS =>'0');
            ELSE 
                RED <= (OTHERS =>'0');
                GREEN <= (OTHERS =>'0');
                BLUE <= (OTHERS =>'0');
            END IF;
            END PROCESS;
end Behavioral;
