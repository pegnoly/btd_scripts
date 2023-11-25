---@alias BankDifficultyVariant
BANK_VARIANT_EASY = "BANK_VARIANT_EASY"
BANK_VARIANT_MEDIUM = "BANK_VARIANT_MEDIUM"
BANK_VARIANT_HARD = "BANK_VARIANT_HARD"

---@alias BankType
BANK_CRYPT = "BANK_CRYPT"
BANK_PYRAMID = "BANK_PYRAMID"
BANK_MAGI_VAULT = "BANK_MAGI_VAULT"
BANK_DRAGON_UTOPIA = "BANK_DRAGON_UTOPIA"
BANK_ELEMENTAL_STOCKPILE = "BANK_ELEMENTAL_STOCKPILE"
BANK_DEMOLISH = "BANK_DEMOLISH"
BANK_UNKEMPT = "BANK_UNKEMPT"
BANK_DWARVEN_TREASURE = "BANK_DWARVEN_TREASURE"
BANK_BLOOD_TEMPLE = "BANK_BLOOD_TEMPLE"
BANK_TREANT_THICKET = "BANK_TREANT_THICKET"
BANK_GARGOYLE_STONEVAULT = "BANK_GARGOYLE_STONEVAULT"
BANK_SUNKEN_TEMPLE = "BANK_SUNKEN_TEMPLE"
BANK_NAGA_TEMPLE = "BANK_NAGA_TEMPLE"
BANK_NAMTARU_TEMPLE = "BANK_NAMTARU_TEMPLE"
BANK_SNOW_APE_CAVE = "BANK_SNOW_APE_CAVE"
BANK_BTDSUNKENTEMPLE = "BANK_BTDSUNKENTEMPLE"

while not BANK_BTDSUNKENTEMPLE do
	sleep()
end

doFile("/scripts/RMG/advmap/Objects/Banks/generated.lua")
-- сгенерированные патчером файлы
doFile(GetMapDataPath().."buildings.lua")
doFile(GetMapDataPath().."treasures.lua")


while not BTD_GENERATED_BANKS_INFO and BTD_BanksInfo do
    sleep()
end

BTD_BANKS_NAMES = 
{
	[BANK_CRYPT] = "/scripts/RMG/advmap/Objects/Banks/Names/crypt.txt",
	[BANK_PYRAMID] = "/scripts/RMG/advmap/Objects/Banks/Names/pyramid.txt",
	[BANK_MAGI_VAULT] = "/scripts/RMG/advmap/Objects/Banks/Names/magi_vault.txt",
	[BANK_DRAGON_UTOPIA] = "/scripts/RMG/advmap/Objects/Banks/Names/dragon_utopia.txt",
	[BANK_ELEMENTAL_STOCKPILE] = "/scripts/RMG/advmap/Objects/Banks/Names/stockpile.txt",
	[BANK_DEMOLISH] = "/scripts/RMG/advmap/Objects/Banks/Names/demolish.txt",
	[BANK_UNKEMPT] = "/scripts/RMG/advmap/Objects/Banks/Names/unkempt.txt",
	[BANK_DWARVEN_TREASURE] = "/scripts/RMG/advmap/Objects/Banks/Names/dwarven.txt",
	[BANK_BLOOD_TEMPLE] = "/scripts/RMG/advmap/Objects/Banks/Names/blood_temple.txt",
	[BANK_TREANT_THICKET] = "/scripts/RMG/advmap/Objects/Banks/Names/treant.txt",
	[BANK_GARGOYLE_STONEVAULT] = "/scripts/RMG/advmap/Objects/Banks/Names/gargoyle.txt",
	[BANK_SUNKEN_TEMPLE] = "/scripts/RMG/advmap/Objects/Banks/Names/sunken_temple.txt",
	[BANK_NAGA_TEMPLE] = "/scripts/RMG/advmap/Objects/Banks/Names/naga_temple.txt",
	[BANK_NAMTARU_TEMPLE] = "/scripts/RMG/advmap/Objects/Banks/Names/namtaru_temple.txt",
	[BANK_SNOW_APE_CAVE] = "/scripts/RMG/advmap/Objects/Banks/Names/snow_ape_cave.txt",
	[BANK_BTDSUNKENTEMPLE] = "/scripts/RMG/advmap/Objects/Banks/Names/btd_sunken_temple.txt"
}

BTD_BANKS_DIFF_NAMES =  
{
	[BANK_VARIANT_EASY] = "/scripts/RMG/advmap/Objects/Banks/Names/guard_lite.txt",
	[BANK_VARIANT_MEDIUM] = "/scripts/RMG/advmap/Objects/Banks/Names/guard_medium.txt",
	[BANK_VARIANT_HARD] = "/scripts/RMG/advmap/Objects/Banks/Names/guard_hard.txt",
}