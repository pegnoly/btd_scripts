function BloodySacrifice_Test()
    for i = 1, 2 do
        GiveHeroSkill("Hero1", SKILL_LUCK)
    end
    GiveHeroSkill("Hero1", HERO_SKILL_DEMONIC_RAGE)
    sleep()
    GiveHeroSkill("Hero1", PERK_FORTUNATE_ADVENTURER)
    sleep()
    GiveHeroSkill("Hero1", 222)
    AddHeroCreatures("Hero1", CREATURE_SHAMAN_WITCH, 10)
end

function WithPowerOfBlood()
    GiveHeroSkill("Hero1", HERO_SKILL_BARBARIAN_LEARNING)
    sleep()
    GiveHeroSkill("Hero1", HERO_SKILL_POWER_OF_BLOOD)
end

function WithVoiceOfRage()
    GiveHeroSkill("Hero1", HERO_SKILL_VOICE)
    sleep()
    GiveHeroSkill("Hero1", HERO_SKILL_VOICE_OF_RAGE)
end