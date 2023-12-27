function TownPortalTest()
    local hero = GetPlayerHeroes(1)[0]
    WarpHeroExp(hero, Levels[20])
    TeachHeroSpell(hero, SPELL_TOWN_PORTAL)
    ChangeHeroStat(hero, STAT_KNOWLEDGE, 10)
    sleep(10)
    ChangeHeroStat(hero, STAT_MANA_POINTS, 100)
    for i, town in GetObjectNamesByType("TOWN") do
        if GetObjectOwner(town) == PLAYER_NONE then
            SetObjectOwner(town, 1)
        end
    end
end
