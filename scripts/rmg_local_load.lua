----------------------------
-- общие для режимов скрипты
----------------------------

-- герои
doFile("/scripts/Common/advmap/Heroes/Kigan/script.lua")
doFile("/scripts/Common/advmap/Heroes/Biara/script.lua")
doFile("/scripts/Common/advmap/Heroes/Krag/script.lua")
doFile("/scripts/Common/advmap/Heroes/Vegeyr/script.lua")
doFile("/scripts/Common/advmap/Heroes/Kujin/script.lua")
doFile("/scripts/Common/advmap/Heroes/Rolf/script.lua")
doFile("/scripts/Common/advmap/Heroes/Valeria/script.lua")

-- скиллы
doFile("/scripts/Common/advmap/Skills/Catapult/script.lua")
doFile("/scripts/Common/advmap/Skills/DemonicRetaliation/script.lua")
doFile("/scripts/Common/advmap/Skills/DefendUsAll/script.lua")
doFile("/scripts/Common/advmap/Skills/GrailVision/script.lua")
doFile("/scripts/Common/advmap/Skills/Navigation/script.lua")
doFile("/scripts/Common/advmap/Skills/Readiness/script.lua")
doFile("/scripts/Common/advmap/Skills/SealOfProtection/script.lua")
doFile("/scripts/Common/advmap/Skills/ShakeGround/script.lua")
doFile("/scripts/Common/advmap/Skills/SorceryDefence/script.lua")
doFile("/scripts/Common/advmap/Skills/TripleCatapult/script.lua")
doFile("/scripts/Common/advmap/Skills/BloodySacrifice/script.lua")
doFile("/scripts/Common/advmap/Skills/BloodyMana/script.lua")
doFile("/scripts/Common/advmap/Skills/LordOfUndead/script.lua")

-- артефакты
doFile("/scripts/Common/advmap/Artifacts/TwistingNeither/script.lua")
--------------
-- рмг-скрипты
--------------

-- герои
doFile("/scripts/RMG/advmap/Heroes/Ferigl/script.lua")
doFile("/scripts/RMG/advmap/Heroes/Astral/script.lua")
doFile("/scripts/RMG/advmap/Heroes/Jazaz/script.lua")
doFile("/scripts/RMG/advmap/Heroes/Nathaniel/script.lua")
doFile("/scripts/RMG/advmap/Heroes/Una/script.lua")

-- банки
doFile("/scripts/RMG/advmap/Objects/Banks/base.lua")
-- генерация армий героев
doFile("/scripts/RMG/advmap/NHF/Common/ArmyGeneration/script.lua")
-- новые объекты
doFile("/scripts/RMG/advmap/Objects/NewObjects/base.lua")
doFile("/scripts/RMG/advmap/Objects/Default/FortuitousSanctuary/script.lua")

-- скиллы
doFile("/scripts/RMG/advmap/Skills/Diplomacy/script.lua")
doFile("/scripts/RMG/advmap/Skills/Estates/script.lua")
doFile("/scripts/RMG/advmap/Skills/NecromancerFeatDeathTread/script.lua")
doFile("/scripts/RMG/advmap/Skills/FortunateAdventurer/script.lua")
doFile("/scripts/RMG/advmap/Skills/GuardianAngel/script.lua")
doFile("/scripts/RMG/advmap/Skills/HeraldOfDeath/script.lua")
doFile("/scripts/RMG/advmap/Skills/Navigation/script.lua")
doFile("/scripts/RMG/advmap/Skills/NoRestForTheWicked/script.lua")
doFile("/scripts/RMG/advmap/Skills/Recruitment/script.lua")
doFile("/scripts/RMG/advmap/Skills/SpoilsOfWar/script.lua")
doFile("/scripts/RMG/advmap/Skills/Wisdom/script.lua")
doFile("/scripts/RMG/advmap/Skills/ForestLeader/script.lua")
doFile("/scripts/RMG/advmap/Skills/DarkRevelation/script.lua")
doFile("/scripts/RMG/advmap/Skills/DisguiseAndReckon/script.lua")
doFile("/scripts/RMG/advmap/Skills/ElementalBalance/script.lua")
doFile("/scripts/RMG/advmap/Skills/MasterOfSecrets/script.lua")
doFile("/scripts/RMG/advmap/Skills/Insights/script.lua")
doFile("/scripts/RMG/advmap/Skills/Scholar/script.lua")
doFile("/scripts/RMG/advmap/Skills/HauntMines/script.lua")

-- абилки
doFile("/scripts/RMG/advmap/Abilities/ArtifactTransfer/script.lua")

-- фичи
doFile("/scripts/RMG/advmap/Features/WinConditions/FinalBattle/script.lua")
doFile("/scripts/RMG/advmap/Features/WinConditions/Economic/script.lua")
doFile("/scripts/RMG/advmap/Features/WinConditions/CaptureObject/script.lua")
doFile("/scripts/RMG/advmap/Features/Portals/script.lua")
doFile("/scripts/RMG/advmap/Features/StartResources/script.lua")
--doFile("/scripts/RMG/advmap/Features/Treasures/script.lua")
dofile("/scripts/RMG/advmap/Features/Blueprints/Dwell13/script.lua")

-- постройки в городах
doFile("/scripts/RMG/advmap/Towns/Common/MagicGuild/script.lua")
doFile("/scripts/RMG/advmap/Towns/Common/ResourceSilo/script.lua")

doFile("/scripts/RMG/advmap/Towns/Buildings/Academy_TreasureCave/script.lua")
doFile("/scripts/RMG/advmap/Towns/Buildings/Haven_Farms/script.lua")
doFile("/scripts/RMG/advmap/Towns/Buildings/Inferno_SacrificialPit/script.lua")
doFile("/scripts/RMG/advmap/Towns/Buildings/Inferno_OrderOfFire/script.lua")
doFile("/scripts/RMG/advmap/Towns/Buildings/Inferno_HallsOfHorror/script.lua")
doFile("/scripts/RMG/advmap/Towns/Buildings/Necropolis_UnearhedGraves/script.lua")
doFile("/scripts/RMG/advmap/Towns/Buildings/Preserve_BloomingGrove/script.lua")
doFile("/scripts/RMG/advmap/Towns/Buildings/Dungeon_RitualPit/script.lua")
doFile("/scripts/RMG/advmap/Towns/Buildings/Common_ArmyRegradeFort/script.lua")
doFile("/scripts/RMG/advmap/Towns/Buildings/Dwarven_RunicStoneworks/script.lua")
doFile("/scripts/RMG/advmap/Towns/Buildings/Dwarven_Treasure/script.lua")
doFile("/scripts/RMG/advmap/Towns/Buildings/Preserve_TreantSamplings/script.lua")
doFile("/scripts/RMG/advmap/Towns/Buildings/Preserve_SparklingFountain/script.lua")

-- режимы
doFile("/scripts/RMG/advmap/Modes/Blitz/CreatureGrow/script.lua")
doFile("/scripts/RMG/advmap/Modes/Krypt/script.lua")

-- спеллы
doFile("/scripts/RMG/advmap/Spells/init.lua")

-- фиксы
--doFile("/scripts/RMG/advmap/Fixes/map_reload_stat_thread.lua")
doFile("/scripts/RMG/advmap/Creatures/Abilities/Namtaru.lua")

print("rmg scripts loaded")