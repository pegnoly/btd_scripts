function FeriglTest()
    WarpHeroExp("Ferigl", Levels[20])
    AddHeroCreatures("Ferigl", CREATURE_RIDER, 10)
    AddHeroCreatures("Ferigl", CREATURE_RAVAGER, 10)
    sleep()
    StartCombat("Ferigl", nil, 1, 4, 40)
end