doFile("/scripts/RMG/advmap/Features/WinConditions/Economic/consts.lua")

while not RareResource do
    sleep()
end

doFile("/scripts/RMG/advmap/Modes/consts.lua")
doFile(GetMapDataPath().."buildings_info.lua")
doFile(GetMapDataPath().."stacks.lua")
doFile(GetMapDataPath().."towns_info.lua")
doFile(GetMapDataPath().."treasures_info.lua")

doFile("/scripts/RMG/test.lua")
-- герои --
-- общие
doFile("/scripts/Common/advmap/Heroes/Kigan/reload.lua")
doFile("/scripts/Common/advmap/Heroes/Biara/reload.lua")
doFile("/scripts/Common/advmap/Heroes/Krag/reload.lua")
doFile("/scripts/Common/advmap/Heroes/Rolf/reload.lua")

doFile("/scripts/Common/advmap/CustomAbility/Artifact/script.lua")

-- скиллы --

-- общие
doFile("/scripts/Common/advmap/Skills/Catapult/reload.lua")
doFile("/scripts/Common/advmap/Skills/DefendUsAll/reload.lua")
doFile("/scripts/Common/advmap/Skills/GrailVision/reload.lua")
doFile("/scripts/Common/advmap/Skills/Readiness/reload.lua")
doFile("/scripts/Common/advmap/Skills/ShakeGround/reload.lua")
doFile("/scripts/Common/advmap/Skills/SorceryDefence/reload.lua")
doFile("/scripts/Common/advmap/Skills/TripleCatapult/reload.lua")
doFile("/scripts/Common/advmap/Skills/BloodySacrifice/reload.lua")
doFile("/scripts/Common/advmap/Skills/BloodyMana/reload.lua")
doFile("/scripts/Common/advmap/Skills/LordOfUndead/reload.lua")
doFile("/scripts/Common/advmap/Skills/HauntMines/reload.lua")

-- артефакты
doFile("/scripts/Common/advmap/Artifacts/TwistingNeither/reload.lua")

-- рмг
doFile("/scripts/RMG/advmap/Skills/GuardianAngel/reload.lua")

-- объекты
doFile("/scripts/RMG/advmap/Objects/Banks/consts.lua")
doFile("/scripts/RMG/advmap/Objects/NewObjects/consts.lua")
doFile("/scripts/RMG/advmap/Objects/NewObjects/WarmenHouse/reload.lua")
doFile("/scripts/RMG/advmap/Objects/NewObjects/DwarvenMine/test.lua")

-- герои 
doFile("/scripts/RMG/advmap/Heroes/Jazaz/reload.lua")

-- фиксы
doFile("/scripts/RMG/advmap/Fixes/combat_connection_fix.lua")
doFile("/scripts/RMG/advmap/Fixes/map_reload_level_fix.lua")
doFile("/scripts/RMG/advmap/Fixes/map_reload_stat_thread.lua")
doFile("/scripts/RMG/advmap/Fixes/owner_reload_fix.lua")

doFile("/scripts/RMG/advmap/Creatures/Abilities/reload.lua")

-- города
doFile("/scripts/RMG/advmap/Towns/Common/MagicGuild/consts.lua")

--
doFile("/scripts/RMG/advmap/Features/WinConditions/Economic/consts.lua")
dofile("/scripts/RMG/advmap/Features/Blueprints/script.lua")
dofile("/scripts/RMG/advmap/Features/Blueprints/Dwell13/generated.lua")

-- тесты
doFile("/scripts/RMG/advmap/Towns/Common/MagicGuild/test.lua")
doFile("/scripts/RMG/advmap/Heroes/Ferigl/test.lua")
doFile("/scripts/RMG/advmap/Heroes/Jazaz/test.lua")
doFile("/scripts/Common/advmap/Skills/Readiness/test.lua")
doFile("/scripts/Common/advmap/Skills/BloodySacrifice/test.lua")
doFile("/scripts/Common/advmap/Skills/BloodyMana/test.lua")
doFile("/scripts/Common/advmap/Skills/LordOfUndead/test.lua")
doFile("/scripts/RMG/advmap/Skills/HauntMines/test.lua")
doFile("/scripts/RMG/advmap/Spells/TownPortal/test.lua")
doFile("/scripts/Common/advmap/Skills/TripleCatapult/test.lua")