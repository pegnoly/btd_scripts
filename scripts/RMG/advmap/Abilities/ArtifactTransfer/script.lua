CUSTOM_ABILITY_ARTIFACT_TRANSFER = CUSTOM_ABILITY_2

artifact_transfer = 
{
    active_for_hero = {},
    distance = 2,
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

CustomAbility.callbacks[CUSTOM_ABILITY_ARTIFACT_TRANSFER] = 
function(hero)
    local closest_hero = ArtifactTransfer_GetClosestHero(hero)
    if closest_hero ~= "" then
        ChangeHeroStat(hero, STAT_MOVE_POINTS, -artifact_transfer.move_points_cost)
        for art = 1, 149 do
            if HasArtefact(hero, art) then
                for i = 1, GetHeroArtifactsCount(hero, art) do
                    RemoveArtefact(hero, art)
                    GiveArtefact(closest_hero, art)
                end
            end
        end
    end
end