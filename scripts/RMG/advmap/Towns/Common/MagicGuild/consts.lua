-- scrolls ids.
SCROLL_LIGHT_L4 = 100
SCROLL_LIGHT_L5 = 101
SCROLL_DARK_L4 = 102
SCROLL_DARK_L5 = 103
SCROLL_SUMMON_L4 = 104
SCROLL_SUMMON_L5 = 105
SCROLL_DESTRUCTIVE_L4 = 106
SCROLL_DESTRUCTIVE_L5 = 107

LVL_STATUS_NOT_UPGRADED = 0 -- guild not upgraded to lvl
LVL_STATUS_PENDING = 1 -- guild upgraded but scroll not given yet
LVL_STATUS_GIVEN = 2 -- scroll given to some hero

LEARN_STATUS_SKIPPED = 0 -- spell learning was cancelled
LEARN_STATUS_NOT_ENOUGH_GOLD = 1 -- can't learn cause of gold issues
LEARN_STATUS_SUCCESS = 2 -- learned successfully

CUSTOM_ABILITY_LEARN_SCROLL_SPELL = 4

-- [town_id] = {schools}
SCHOOLS_BY_TOWNS = {
    [TOWN_HEAVEN] = {MAGIC_SCHOOL_LIGHT, MAGIC_SCHOOL_DARK},
    [TOWN_ACADEMY] = {MAGIC_SCHOOL_LIGHT, MAGIC_SCHOOL_SUMMONING},
    [TOWN_DUNGEON] = {MAGIC_SCHOOL_DESTRUCTIVE, MAGIC_SCHOOL_SUMMONING},
    [TOWN_PRESERVE] = {MAGIC_SCHOOL_LIGHT, MAGIC_SCHOOL_DESTRUCTIVE},
    [TOWN_NECROMANCY] = {MAGIC_SCHOOL_DARK, MAGIC_SCHOOL_SUMMONING},
    [TOWN_INFERNO] = {MAGIC_SCHOOL_DESTRUCTIVE, MAGIC_SCHOOL_DARK},
    [TOWN_FORTRESS] = {MAGIC_SCHOOL_DESTRUCTIVE, MAGIC_SCHOOL_LIGHT}
}

-- [school] = {[guild_lvl] = scroll}
SCROLLS_BY_SCHOOLS = {
    [MAGIC_SCHOOL_LIGHT] = {
        [4] = SCROLL_LIGHT_L4,
        [5] = SCROLL_LIGHT_L5
    },
    [MAGIC_SCHOOL_DARK] = {
        [4] = SCROLL_DARK_L4,
        [5] = SCROLL_DARK_L5
    },
    [MAGIC_SCHOOL_SUMMONING] = {
        [4] = SCROLL_SUMMON_L4,
        [5] = SCROLL_SUMMON_L5
    },
    [MAGIC_SCHOOL_DESTRUCTIVE] = {
        [4] = SCROLL_DESTRUCTIVE_L4,
        [5] = SCROLL_DESTRUCTIVE_L5
    }
}

SCHOOLS_BY_SCROLLS = {
    [SCROLL_LIGHT_L4] = MAGIC_SCHOOL_LIGHT,
    [SCROLL_LIGHT_L5] = MAGIC_SCHOOL_LIGHT,
    [SCROLL_DARK_L4] = MAGIC_SCHOOL_DARK,
    [SCROLL_DARK_L5] = MAGIC_SCHOOL_DARK,
    [SCROLL_SUMMON_L4] = MAGIC_SCHOOL_SUMMONING,
    [SCROLL_SUMMON_L5] = MAGIC_SCHOOL_SUMMONING,
    [SCROLL_DESTRUCTIVE_L4] = MAGIC_SCHOOL_DESTRUCTIVE,
    [SCROLL_DESTRUCTIVE_L5] = MAGIC_SCHOOL_DESTRUCTIVE
}

SKILLS_BY_SCHOOLS = {
    [MAGIC_SCHOOL_LIGHT] = SKILL_LIGHT_MAGIC,
    [MAGIC_SCHOOL_DARK] = SKILL_DARK_MAGIC,
    [MAGIC_SCHOOL_SUMMONING] = SKILL_SUMMONING_MAGIC,
    [MAGIC_SCHOOL_DESTRUCTIVE] = SKILL_DESTRUCTIVE_MAGIC
}

-- cost in gold by spell level(from duel)
COST_BY_LEVEL = {
    [4] = 4250,
    [5] = 7000
}

-- will use this before regeneration of files
SPELLS_BY_SCHOOL_LEVEL = {
    [MAGIC_SCHOOL_LIGHT] = {
        [4] = {SPELL_HOLY_WORD, SPELL_ANTI_MAGIC, SPELL_TELEPORT},
        [5] = {SPELL_DIVINE_VENGEANCE, SPELL_RESURRECT}
    },
    [MAGIC_SCHOOL_DARK] = {
        [4] = {SPELL_BLIND, SPELL_BERSERK, SPELL_UNHOLY_WORD},
        [5] = {SPELL_HYPNOTIZE, SPELL_VAMPIRISM}
    },
    [MAGIC_SCHOOL_SUMMONING] = {
        [4] = {SPELL_SUMMON_ELEMENTALS, SPELL_SUMMON_HIVE},
        [5] = {SPELL_CELESTIAL_SHIELD, SPELL_CONJURE_PHOENIX}
    },
    [MAGIC_SCHOOL_DESTRUCTIVE] = {
        [4] = {SPELL_CHAIN_LIGHTNING, SPELL_METEOR_SHOWER},
        [5] = {SPELL_ARMAGEDDON, SPELL_DEEP_FREEZE, SPELL_IMPLOSION}
    }
}

--
SCROLL_ACTIVATION_CONDITONS = {
    [SCROLL_LIGHT_L4] = function(hero) return GetHeroSkillMastery(hero, SKILL_LIGHT_MAGIC) >= 2 end,
    [SCROLL_LIGHT_L5] = function(hero) return GetHeroSkillMastery(hero, SKILL_LIGHT_MAGIC) == 3 end,
    [SCROLL_DARK_L4] = function(hero) return GetHeroSkillMastery(hero, SKILL_DARK_MAGIC) >= 2 end,
    [SCROLL_DARK_L5] = function(hero) return GetHeroSkillMastery(hero, SKILL_DARK_MAGIC) == 3 end,
    [SCROLL_SUMMON_L4] = function(hero) return GetHeroSkillMastery(hero, SKILL_SUMMONING_MAGIC) >= 2 end,
    [SCROLL_SUMMON_L5] = function(hero) return GetHeroSkillMastery(hero, SKILL_SUMMONING_MAGIC) == 3 end,
    [SCROLL_DESTRUCTIVE_L4] = function(hero) return GetHeroSkillMastery(hero, SKILL_DESTRUCTIVE_MAGIC) >= 2 end,
    [SCROLL_DESTRUCTIVE_L5] = function(hero) return GetHeroSkillMastery(hero, SKILL_DESTRUCTIVE_MAGIC) == 3 end
}

SHORT_NAMES_BY_SCHOOLS = {
    [MAGIC_SCHOOL_DESTRUCTIVE] = "/scripts/RMG/advmap/Towns/Common/MagicGuild/ScrollsShortNames/destructive.txt",
    [MAGIC_SCHOOL_SUMMONING] = "/scripts/RMG/advmap/Towns/Common/MagicGuild/ScrollsShortNames/summon.txt",
    [MAGIC_SCHOOL_DARK] = "/scripts/RMG/advmap/Towns/Common/MagicGuild/ScrollsShortNames/dark.txt",
    [MAGIC_SCHOOL_LIGHT] = "/scripts/RMG/advmap/Towns/Common/MagicGuild/ScrollsShortNames/light.txt",
}

QBOX_MESSAGES_BY_LEVELS = {
    [4] = "/scripts/RMG/advmap/Towns/Common/MagicGuild/SpellDialog/scroll_choise_l4.txt",
    [5] = "/scripts/RMG/advmap/Towns/Common/MagicGuild/SpellDialog/scroll_choise_l5.txt"
}