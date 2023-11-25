CUSTOM_ABILITY_ARTIFACT_TRANSFER = CUSTOM_ABILITY_2

artifact_transfer = 
{
    active_for_hero = {},
    distance = 2,
    untransferable_artifacts = {
        ARTIFACT_WAND_OF_X, ARTIFACT_SCROLL_OF_SPELL_X, 
        100, 101, 102, 103, 104, 105, 106, 107, 108, 109, 110, 111, 112, 113, 114, 115, 116},
    move_points_cost = 100
}

AddHeroEvent.AddListener("BTD_RMG_artifact_transfer_add_hero",
function(hero)
    ControlHeroCustomAbility(hero, CUSTOM_ABILITY_ARTIFACT_TRANSFER, CUSTOM_ABILITY_DISABLED)
    artifact_transfer.active_for_hero[hero] = nil
    startThread(
    function()
        while 1 do
            if IsHeroAlive(%hero) then
                if not artifact_transfer.active_for_hero[%hero] then
                    if ArtifactTransfer_CanBePerformed(%hero) then
                        artifact_transfer.active_for_hero[%hero] = 1
                        ControlHeroCustomAbility(%hero, CUSTOM_ABILITY_ARTIFACT_TRANSFER, CUSTOM_ABILITY_ENABLED)
                    end
                else
                    if not ArtifactTransfer_CanBePerformed(%hero) then
                        artifact_transfer.active_for_hero[%hero] = nil
                        ControlHeroCustomAbility(%hero, CUSTOM_ABILITY_ARTIFACT_TRANSFER, CUSTOM_ABILITY_DISABLED)
                    end
                end
            end
            sleep()
        end 
    end)
end)

function ArtifactTransfer_CanBePerformed(hero)
    if GetHeroStat(hero, STAT_MOVE_POINTS) < artifact_transfer.move_points_cost then
        return nil
    end
    local has_close
    local player = GetObjectOwner(hero)
    for i, c_hero in GetObjectNamesByType("HERO") do
        if c_hero ~= hero then
            local c_player = GetObjectOwner(c_hero)
            if GetPlayerTeam(player) == GetPlayerTeam(c_player) then
                local dist = Object.Distance(hero, c_hero)
                if dist and dist <= artifact_transfer.distance then
                    has_close = 1
                    break
                end
            end
        end
    end
    return has_close    
end

function ArtifactTransfer_GetClosestHero(hero)
    local closest_hero = ""
    local current_closest_distance = math.huge
    local player = GetObjectOwner(hero)
    for i, c_hero in GetObjectNamesByType("HERO") do
        if c_hero ~= hero then
            local c_player = GetObjectOwner(c_hero)
            if GetPlayerTeam(player) == GetPlayerTeam(c_player) then
                local dist = Object.Distance(hero, c_hero)
                if dist and dist <= artifact_transfer.distance and dist < current_closest_distance then
                    current_closest_distance = dist
                    closest_hero = c_hero
                end
            end
        end
    end
    return closest_hero
end

function ArtifactTransfer_RemoveArts(hero, art, count)
    for i = 1, count do
        RemoveArtefact(hero, art)
    end    
end

function ArtifactTransfer_GiveArts(hero, art, count)
    for i = 1, count do
        GiveArtefact(hero, art)
    end
end

CustomAbility.callbacks[CUSTOM_ABILITY_ARTIFACT_TRANSFER] = 
function(hero)
    consoleCmd("setvar ui_announcement_duration = 0")
    sleep()
    local closest_hero = ArtifactTransfer_GetClosestHero(hero)
    if closest_hero ~= "" then
        for i = 100, 108 do
            GiveArtefact(closest_hero, i)
        end
        sleep()
        ChangeHeroStat(hero, STAT_MOVE_POINTS, -artifact_transfer.move_points_cost)
        local arts_to_return, a_n = {}, 0
        for art = 1, 149 do
            if not contains(artifact_transfer.untransferable_artifacts, art) then
                local remove_art_count = GetHeroArtifactsCount(hero, art)
                local give_art_count = HasArtefact(hero, art, 1) and remove_art_count - 1 or remove_art_count
                if remove_art_count > give_art_count then
                    a_n = a_n + 1
                    arts_to_return[a_n] = art
                end
                startThread(ArtifactTransfer_RemoveArts, hero, art, remove_art_count)
                startThread(ArtifactTransfer_GiveArts, closest_hero, art, give_art_count)
                while GetHeroArtifactsCount(hero, art) ~= 0 and GetHeroArtifactsCount(closest_hero, art) ~= give_art_count do
                    sleep()
                end
            end
        end
        sleep()
        if a_n > 0 then
            for i, art in arts_to_return do
                GiveArtefact(hero, art)
            end
        end
        sleep()
        for i = 100, 108 do
            --print("ok, ", i)
            if HasArtefact(closest_hero, i) then
                RemoveArtefact(closest_hero, i)
            end
        end
        sleep()
        consoleCmd("setvar ui_announcement_duration = 3500")
        MakeHeroInteractWithObject(hero, closest_hero)
    end
end