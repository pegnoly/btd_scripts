MCCS_GAME_MODES = {}

GAME_MODE_COMMON = 1
GAME_MODE_OUTCAST = 2
GAME_MODE_BLITZ = 3
GAME_MODE_KRYPT = 4
GAME_MODE_FINAL_BATTLE = 5
GAME_MODE_CAPTURE_OBJECT = 6
GAME_MODE_ECONOMIC = 7
GAME_MODE_EXPERIMENTALARTS = 8

doFile(GetMapDataPath().."modes_info.lua")
while not MCCS_GAME_MODES do
    sleep()
end