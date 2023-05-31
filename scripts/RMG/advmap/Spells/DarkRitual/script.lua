-- return move points when casting Dark Ritual

DarkRitualExtension = {
    CheckDarkRitualCast = function(tHeroStorage)
        for sHeroName, vStored in tHeroStorage do
            if IsHeroAlive(sHeroName) 
                and not GetHeroTown(sHeroName) 
                and HasHeroSkill(sHeroName, PERK_DARK_RITUAL)
            then
                local newMP = GetHeroStat(sHeroName, STAT_MOVE_POINTS)
                local oldMP = vStored.movePoints
                local maxMP = vStored.maxMovePoints
                local newMana = GetHeroStat(sHeroName, STAT_MANA_POINTS)
                
                if maxMP and maxMP == oldMP and newMP == 0 and newMana > vStored.mana
                then
                    print(sHeroName.." casts Dark Ritual")

                    local level = GetHeroLevel(sHeroName)

                    -- formula for returning mana: 20% + additional 10% after every 10 levels
                    local mpBonus = floor(maxMP * (0.2 + 0.1 * floor(level / 10)))
                    
                    ChangeHeroStat(sHeroName, STAT_MOVE_POINTS, mpBonus)
                end
            end
        end
    end,
}