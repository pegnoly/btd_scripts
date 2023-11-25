function BloodyMana_Test()
    for i = 1, 2 do
        GiveHeroSkill("Hero1", HERO_SKILL_VOICE)
    end
    sleep()
    GiveHeroSkill("Hero1", HERO_SKILL_BARBARIAN_MYSTICISM)
    sleep()
    GiveHeroSkill("Hero1", 224)
    AddHeroCreatures("Hero1", CREATURE_CENTAUR, 1000)
    -- sleep()
    -- GiveHeroSkill("Hero1", 222)
    -- AddHeroCreatures("Hero1", CREATURE_SHAMAN_WITCH, 10)
end