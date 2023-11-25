function HauntMinesRMG_Test()
    for i = 1, 2 do
        GiveHeroSkill("Aberrar", SKILL_SUMMONING_MAGIC)
    end
    sleep()
    GiveHeroSkill("Aberrar", PERK_DEATH_SCREAM)
    GiveHeroSkill("Aberrar", PERK_MASTER_OF_ANIMATION)
    GiveHeroSkill("Aberrar", 223)
    WarpHeroExp("Aberrar", Levels[10])
    AddHeroCreatures("Aberrar", CREATURE_GHOST, 100)
    AddHeroCreatures("Aberrar", CREATURE_POLTERGEIST, 100)
    OpenCircleFog(0, 0, 0, 999, GetObjectOwner("Aberrar"))
    startThread(
    function()
        while 1 do
            ChangeHeroStat("Aberrar", STAT_MOVE_POINTS, 10000)
            sleep()
        end
    end)
end