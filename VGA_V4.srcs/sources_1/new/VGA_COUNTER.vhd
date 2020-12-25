
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
USE IEEE.STD_LOGIC_UNSIGNED.ALL;
USE IEEE.STD_LOGIC_ARITH.ALL;

LIBRARY WORK;
USE WORK.VGA_SETTINGS.ALL;

entity VGA_COUNTER is
  Port (
        CLK_IN : IN STD_LOGIC;
        H_SYNC : OUT STD_LOGIC;
        V_SYNC : OUT STD_LOGIC;
        ----- PIXELS POSITION ---
        H_COUNT : OUT STD_LOGIC_VECTOR ( H_COUNT_WIDTH -1 DOWNTO 0);
        V_COUNT : OUT STD_LOGIC_VECTOR ( V_COUNT_WIDTH -1 DOWNTO 0);
        ---- ACTIVE AREA -------
        VIDEO_EN : OUT STD_LOGIC
         );
end VGA_COUNTER;

architecture Behavioral of VGA_COUNTER is

---HORIZONTAL AND VERTICAL COUNTERS -----
SIGNAL H_CNT : STD_LOGIC_VECTOR(H_COUNT_WIDTH -1 DOWNTO 0) := (OTHERS => '0');
SIGNAL V_CNT : STD_LOGIC_VECTOR(V_COUNT_WIDTH -1 DOWNTO 0) := (OTHERS => '0');

begin
    H_COUNTER : PROCESS( CLK_IN)
                BEGIN
                IF RISING_EDGE(CLK_IN) THEN
                    IF H_CNT = H_TOTAL THEN
                        H_CNT <= (OTHERS => '0');
                    ELSE 
                        H_CNT <= H_CNT +1;
                    END IF;
                END IF;
                END PROCESS;
    V_COUNTER : PROCESS ( CLK_IN)
                BEGIN
                IF RISING_EDGE( CLK_IN) THEN
                    IF H_CNT = H_TOTAL THEN
                        IF V_CNT = V_TOTAL THEN
                            V_CNT <= (OTHERS => '0');
                        ELSE 
                            V_CNT <= V_CNT+1;
                        END IF;
                    END IF;
                END IF;
                END PROCESS;
    H_SYNC_GEN: PROCESS (H_CNT) 
                BEGIN
                    IF ( H_CNT > H_PULSE ) THEN
                        H_SYNC <= '1';
                    ELSE 
                        H_SYNC <= '0';
                    END IF;
                END PROCESS;
    V_SYNC_GEN: PROCESS(V_CNT)
                BEGIN
                    IF ( V_CNT > V_PULSE) THEN
                        V_SYNC <= '1';
                    ELSE 
                        V_SYNC <= '0';
                    END IF;
                END PROCESS;
    VIDEO_EN <= '1' WHEN ( H_CNT >= H_ON_DISPLAY AND H_CNT < H_OFF_DISPLAY)
                            AND
                        ( V_CNT >= V_ON_DISPLAY AND V_CNT< V_OFF_DISPLAY)
                    ELSE 
                '0';
    V_COUNT <= V_CNT;
    H_COUNT <= H_CNT;
end Behavioral;
