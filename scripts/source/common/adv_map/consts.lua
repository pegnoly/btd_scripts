---@alias PlayerColor
---|`PCOLOR_NEUTRAL`
---|`PCOLOR_RED`
---|`PCOLOR_BLUE`
---|`PCOLOR_GREEN`
---|`PCOLOR_YELLOW`
---|`PCOLOR_ORANGE`
---|`PCOLOR_TEAL`
---|`PCOLOR_PURPLE`
---|`PCOLOR_BROWN`
PCOLOR_NEUTRAL = 0
PCOLOR_RED = 1
PCOLOR_BLUE = 2
PCOLOR_GREEN = 3
PCOLOR_YELLOW = 4
PCOLOR_ORANGE = 5
PCOLOR_TEAL = 6
PCOLOR_PURPLE = 7
PCOLOR_BROWN = 8


decorativePlayers = {}

mainPath = GetMapDataPath().."/"

diffExpCoeffs = {2, 1, 0.77, 0.67}

Levels = {1, 1000, 2000, 3200, 4600, 6200, 8000, 10000, 12200, 14700, 17500, 20600, 24320,
28784, 34141, 40569, 48283, 57539, 68647, 81977, 97972, 117166, 140200, 167839,
201007, 244126, 304491, 395040, 539917, 786208, 1229533, 2071850, 3756484, 7294215,
15077224, 32978144, 75940353, 183345874, 462600229, 1216586989}

StatNames =
{
	[STAT_EXPERIENCE] = "/Text/Default/Stats/Experience.txt",
	[STAT_ATTACK] = "/Text/Default/Stats/Attack.txt",
	[STAT_DEFENCE] = "/Text/Default/Stats/Defence.txt",
	[STAT_SPELL_POWER] = "/Text/Default/Stats/Spellpower.txt",
	[STAT_KNOWLEDGE] = "/Text/Default/Stats/Knowledge.txt",
	[STAT_LUCK] = "/Text/Default/Stats/Luck.txt",
	[STAT_MORALE] = "/Text/Default/Stats/Morale.txt"
}

ResNames =
{
	[WOOD] = "/Text/Game/Treasures/Wood/Name.txt",
	[ORE] = "/Text/Game/Treasures/Ore/Name.txt",
	[MERCURY] = "/Text/Game/Treasures/Mercury/Name.txt",
	[CRYSTAL] = "/Text/Game/Treasures/Crystals/Name.txt",
	[SULFUR] = "/Text/Game/Treasures/Sulfur/Name.txt",
	[GEM] = "/Text/Game/Treasures/Gems/Name.txt",
	[GOLD] = "/Text/Game/Treasures/Gold/Name.txt",
}

CaptureFX =
{
	[TOWN_HEAVEN] = "/Effects/_(Effect)/Buildings/Capture/Haven/",
	[TOWN_INFERNO] = "/Effects/_(Effect)/Buildings/Capture/Inferno/",
	[TOWN_NECROMANCY] = "/Effects/_(Effect)/Buildings/Capture/Necropolis/",
	[TOWN_PRESERVE] = "/Effects/_(Effect)/Buildings/Capture/Sylvan/",
	[TOWN_DUNGEON] = "/Effects/_(Effect)/Buildings/Capture/Dungeon/",
	[TOWN_ACADEMY] = "/Effects/_(Effect)/Buildings/Capture/Academy/",
	[TOWN_FORTRESS] = "/Effects/_(Effect)/Buildings/Capture/Fortress/",
	[TOWN_STRONGHOLD] = "/Effects/_(Effect)/Buildings/Capture/Orcs/"
}

CaptureColor =
{
	[PCOLOR_RED] = "02Red.xdb#xpointer(/Effect)",
	[PCOLOR_BLUE] = "07Blue.xdb#xpointer(/Effect)",
	[PCOLOR_GREEN] = "05Green.xdb#xpointer(/Effect)",
	[PCOLOR_YELLOW] = "04Yellow.xdb#xpointer(/Effect)",
	[PCOLOR_ORANGE] = "03Orange.xdb#xpointer(/Effect)",
	[PCOLOR_TEAL] = "06Azure.xdb#xpointer(/Effect)",
	[PCOLOR_PURPLE] = "08Violet.xdb#xpointer(/Effect)",
	[PCOLOR_BROWN] = "01Brown.xdb#xpointer(/Effect)"
}