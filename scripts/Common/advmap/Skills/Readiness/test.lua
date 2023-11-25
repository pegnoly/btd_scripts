function ReadinessTest()
    GiveHeroSkill("Astral", SKILL_OFFENCE)
    GiveHeroSkill("Astral", PERK_TACTICS)
    for i = 1, 3 do
        GiveHeroSkill("Astral", SKILL_DEFENCE)
    end
    GiveHeroSkill("Astral", PERK_TOUGHNESS)
    GiveHeroSkill("Astral", KNIGHT_FEAT_HOLD_GROUND)
    GiveHeroSkill("Astral", HERO_SKILL_PREPARATION)

    AddHeroCreatures("Astral", CREATURE_GREMLIN, 10)
    AddHeroCreatures("Astral", CREATURE_STONE_GARGOYLE, 10)
    AddHeroCreatures("Astral", CREATURE_IRON_GOLEM, 10)
    AddHeroCreatures("Astral", CREATURE_MAGI, 10)
    AddHeroCreatures("Astral", CREATURE_GENIE, 10)
    AddHeroCreatures("Astral", CREATURE_RAKSHASA, 10)
    AddHeroCreatures("Astral", CREATURE_TITAN, 10)
end