MCCS_TEMPLATE_TYPE = nil

TEMPLATE_TYPE_Common = 1
TEMPLATE_TYPE_Outcast = 2
TEMPLATE_TYPE_Blitz = 3
TEMPLATE_TYPE_Krypt = 4

doFile(GetMapDataPath().."template_info.lua")
while not MCCS_TEMPLATE_TYPE do
    sleep()
end