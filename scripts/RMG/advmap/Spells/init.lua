--- Init common logic for tracking map spell casts
doFile('/scripts/RMG/advmap/Spells/TownPortal/script.lua')
doFile('/scripts/RMG/advmap/Spells/DarkRitual/script.lua')

MapSpellsCheckers = {
    tHeroStorage = {},

    OnAddHero = function(sHeroName)
        MapSpellsCheckers.tHeroStorage[sHeroName] = {
            mana = GetHeroStat(sHeroName, STAT_MANA_POINTS),
            xp = GetHeroStat(sHeroName, STAT_EXPERIENCE),
            movePoints = GetHeroStat(sHeroName, STAT_MOVE_POINTS)
        }
    end,

    UpdateHeroStats = function()
        for sName, _ in MapSpellsCheckers.tHeroStorage do
            if IsHeroAlive(sName) then
                MapSpellsCheckers.tHeroStorage[sName].mana = GetHeroStat(sName, STAT_MANA_POINTS)
                MapSpellsCheckers.tHeroStorage[sName].xp = GetHeroStat(sName, STAT_EXPERIENCE)
                MapSpellsCheckers.tHeroStorage[sName].movePoints = GetHeroStat(sName, STAT_MOVE_POINTS)
            end
        end        
    end
}

MapLoadingEvent.AddListener('BTD_RMG_advmap_spell_checker_init', 
function()
    for _, sHeroName in GetObjectNamesByType('HERO') do
        MapSpellsCheckers.OnAddHero(sHeroName)
    end

    startThread(function()
        while 1 do 
            if TownPortalExtension then TownPortalExtension.CheckTpCast(MapSpellsCheckers.tHeroStorage) end
            if DarkRitualExtension then DarkRitualExtension.CheckDarkRitualCast(MapSpellsCheckers.tHeroStorage) end

            MapSpellsCheckers.UpdateHeroStats()
            sleep()
        end
    end)
end)

AddHeroEvent.AddListener('BTD_RMG_advmap_spell_checker_add_hero_event', MapSpellsCheckers.OnAddHero)

NewDayEvent.AddListener('BTD_RMG_advmap_spell_checker_new_day_event',
function()
    for _, sHeroName in GetObjectNamesByType('HERO') do
        if MapSpellsCheckers.tHeroStorage[sHeroName] == nil then
            MapSpellsCheckers.OnAddHero(sHeroName)
        end
        
        MapSpellsCheckers.tHeroStorage[sHeroName].maxMovePoints = GetHeroStat(sHeroName, STAT_MOVE_POINTS)
    end
end)