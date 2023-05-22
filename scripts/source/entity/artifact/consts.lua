---@alias ArtifactClass
---|`ARTF_CLASS_MINOR` # минор
---|`ARTF_CLASS_MAJOR` # мажор
---|`ARTF_CLASS_RELIC` # релик
---|`ARTF_CLASS_GRAIL` # грааль
ARTF_CLASS_MINOR = 1
ARTF_CLASS_MAJOR = 2
ARTF_CLASS_RELIC = 3
ARTF_CLASS_GRAIL = 4

---@alias ArtifactSlot
---|`PRIMARY` 
---|`SECONDARY` 
---|`HEAD` 
---|`CHEST` 
---|`NECK` 
---|`FINGER` 
---|`FEET` 
---|`SHOULDERS` 
---|`MISCSLOT1` 
---|`INVENTORY` 
PRIMARY = 1
SECONDARY = 2
HEAD = 3
CHEST = 4
NECK = 5
FINGER = 6
FEET = 7
SHOULDERS = 8
MISCSLOT1 = 9
INVENTORY = 10

artsByClass =
{
	[ARTF_CLASS_MINOR] = {},
	[ARTF_CLASS_MAJOR] = {},
	[ARTF_CLASS_RELIC] = {}
}

artsBySlot =
{
	[PRIMARY] = {},
	[SECONDARY] = {},
	[HEAD] = {},
	[CHEST] = {},
	[NECK] = {},
	[FINGER] = {},
	[FEET] = {},
	[SHOULDERS] = {},
	[MISCSLOT1] = {},
	[INVENTORY] = {},
}