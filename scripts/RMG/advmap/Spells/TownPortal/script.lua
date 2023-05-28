--- allows lvl 20+ hero to teleport to any town with Magic Guild built

town_portal_question_box = '/scripts/RMG/advmap/Spells/TownPortal/tp_question_box.txt'
town_portal_tile_occupied = '/scripts/RMG/advmap/Spells/TownPortal/tile_occupied.txt'

TownPortalExtension = {
    MIN_HERO_LEVEL = 20,

    tTownSelectorStorage = {},
    tEntranceStorage = {},

    CheckTpCast = function(tHeroStorage)
        for sHeroName, vStored in tHeroStorage do
            if IsHeroAlive(sHeroName) 
                and GetHeroLevel(sHeroName) >= TownPortalExtension.MIN_HERO_LEVEL
                and not GetHeroTown(sHeroName) 
                and KnowHeroSpell(sHeroName, SPELL_TOWN_PORTAL)
            then
                local newMana = GetHeroStat(sHeroName, STAT_MANA_POINTS)
                local newMovePoints = GetHeroStat(sHeroName, STAT_MOVE_POINTS)
                local nX, nY, nFloorID = GetObjectPosition(sHeroName)
                local xp = GetHeroStat(sHeroName, STAT_EXPERIENCE)
    
                if newMovePoints == 0 and vStored.mana - newMana == 20 and vStored.xp == xp then
                    local sTownName = GetHeroTown_Gate(sHeroName)
                    if sTownName then
                        print (sHeroName.." teleported into "..sTownName) --todo: remove
                        local nPlayerID = GetObjectOwner(sHeroName)
    
                        TownPortalExtension.tTownSelectorStorage[nPlayerID] = {
                            towns = GetPlayerTowns(nPlayerID),
                            currTown = sTownName,
                            hero = sHeroName,
                            index = 1
                        }
    
                        TownPortalExtension.TownSelector(nPlayerID)
                    end
                end
            end
        end
    end,


    TownSelector = function(nPlayerID)
        local vSelector = TownPortalExtension.tTownSelectorStorage[nPlayerID]
        local sTownName = vSelector.towns[vSelector.index]

        local WALKERS_HUT = TOWN_BUILDING_STRONGHOLD_TRAVELLERS_SHELTER
        
        if sTownName ~= vSelector.currTown and (
            GetTownBuildingLevel(sTownName, TOWN_BUILDING_MAGIC_GUILD) == 1
            or (
                contains(GetObjectNamesByType('TOWN_STRONGHOLD'), sTownName)
                and
                GetTownBuildingLevel(sTownName, WALKERS_HUT) == 1
            ))
        then
            local nX, nY, nFloorID = GetObjectPosition(sTownName)
            
            MoveCamera(nX, nY, nFloorID, 50, 0, 0, 0, 1)
            
            QuestionBox2(nPlayerID, town_portal_question_box,
                'TownPortalExtension.TpYes('..nPlayerID..')', 'TownPortalExtension.TpNo('..nPlayerID..')')
        else
            TownPortalExtension.TpNo(nPlayerID)
        end
    end,
    

    TpYes = function(nPlayerID)
        local vSelector = TownPortalExtension.tTownSelectorStorage[nPlayerID]
        local vDest = TownPortalExtension.tEntranceStorage[vSelector.towns[vSelector.index]]
        
        if not IsTilePassable(vDest.x, vDest.y, vDest.floorID) then
            print("<color=yellow>WARNING: Can't find town entrance")
            ShowFlyingSign(town_portal_tile_occupied, vSelector.hero, nPlayerID, 5)
            return parse('')
        end
        
        SetObjectPosition(vSelector.hero, vDest.x, vDest.y, vDest.floorID)
            
        return parse('')
    end,
    

    TpNo = function(nPlayerID)
        local vSelector = TownPortalExtension.tTownSelectorStorage[nPlayerID]
        
        if vSelector.index + 1 <= length(vSelector.towns) then
            TownPortalExtension.tTownSelectorStorage[nPlayerID].index = vSelector.index + 1
            TownPortalExtension.TownSelector(nPlayerID)
        end
        return parse('')
    end
}

-- NOTE: town entrance tile is calculated when hero is visiting town.
-- if town was never visited - entrance tile is unknown
MapLoadingEvent.AddListener('BTD_RMG_advmap_town_portal_init',
function()
    for _, sTownName in GetObjectNamesByType('TOWN') do
        Touch.SetFunction(sTownName, 'BTD_town_touch',
        function(hero, town)
            local nX, nY, nFloor = GetObjectPosition(hero)
            TownPortalExtension.tEntranceStorage[town] = { x = nX, y = nY, floorID = nFloor }
        end)
    end
end)

AddHeroEvent.AddListener('BTD_RMG_advmap_town_portal_add_hero_event',
function(hero)
    local town = GetHeroTown_Gate(hero)
    if town then
        local nX, nY, nFloor = GetObjectPosition(hero)
        TownPortalExtension.tEntranceStorage[town] = { x = nX, y = nY, floorID = nFloor }
    end
end)



-----------------------------------------
-- TODO: move in common helper functions
function GetHeroTown_Gate(sHeroName)
    for _, sTownName in GetObjectNamesByType('TOWN') do
        if IsHeroInTown(sHeroName, sTownName, 1, 0) then
            return sTownName
        end
    end

    return nil
end

function GetPlayerTowns(nPlayerID)
    local t = {}
    for _, sTownName in GetObjectNamesByType('TOWN') do
        if GetObjectOwner(sTownName) == nPlayerID then
            t[length(t) + 1] = sTownName
        end
    end
    
    return t
end

function QuestionBox2(nPlayerID, messageName, callbackYes, callbackNo)
    if IsAIPlayer(nPlayerID) == 1 then return end
    
    QuestionBoxForPlayers(GetPlayerFilter(nPlayerID), messageName,
        callbackYes, callbackNo)
end