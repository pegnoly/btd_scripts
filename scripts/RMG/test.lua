function Tt()
    local hero = GetPlayerHeroes(1)[0]
    AddHeroCreatures(hero, CREATURE_PHOENIX, 100)
    startThread(Hero.Threads.UnlimMove, hero, function ()
        return 1
    end)
    OpenCircleFog(0, 0, 0, 999, 1)
end