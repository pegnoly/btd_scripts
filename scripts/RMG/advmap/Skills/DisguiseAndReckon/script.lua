CUSTOM_ABILITY_DISGUISE_AND_RECKON_ACTIVATE = 4

disguise_and_reckon_rmg = 
{
    active_for_hero = {},
    cooldown_for_hero = {},
    cooldown_in_days = 7
}

NewDayEvent.AddListener("BTD_RMG_disguise_and_reckon_new_day",
function(day)
    for hero, alive in AdvMapHeroesInfo.alive_heroes do
        if hero and alive and disguise_and_reckon_rmg.cooldown_for_hero[hero] then
            disguise_and_reckon_rmg.cooldown_for_hero[hero] = disguise_and_reckon_rmg.cooldown_for_hero[hero] - 1
            if disguise_and_reckon_rmg.cooldown_for_hero[hero] == 0 then
                disguise_and_reckon_rmg.cooldown_for_hero[hero] = nil
                if disguise_and_reckon_rmg.active_for_hero[hero] then
                    startThread(DisguiseAndReckon_Activate, hero)
                end
            end
        end
    end
end)

AddHeroEvent.AddListener("BTD_RMG_disguise_and_reckon_add_hero",
function(hero)
    disguise_and_reckon_rmg.cooldown_for_hero[hero] = nil
    startThread(
    function()
        while 1 do
            if IsHeroAlive(%hero) then
                if not disguise_and_reckon_rmg.active_for_hero[%hero] then
                    if HasHeroSkill(%hero, RANGER_FEAT_DISGUISE_AND_RECKON) then
                        --ControlHeroCustomAbility(%hero, CUSTOM_ABILITY_DISGUISE_AND_RECKON_ACTIVATE, CUSTOM_ABILITY_ENABLED)
                        disguise_and_reckon_rmg.active_for_hero[%hero] = 1
                        if not disguise_and_reckon_rmg.cooldown_for_hero[%hero] then
                            startThread(DisguiseAndReckon_Activate, %hero)
                        end
                    end
                else
                    if not HasHeroSkill(%hero, RANGER_FEAT_DISGUISE_AND_RECKON) then
                        --ControlHeroCustomAbility(%hero, CUSTOM_ABILITY_DISGUISE_AND_RECKON_ACTIVATE, CUSTOM_ABILITY_NOT_PRESENT)
                        disguise_and_reckon_rmg.active_for_hero[%hero] = nil
                    end
                end
            end
            sleep() 
        end
    end)
end)

function DisguiseAndReckon_Activate(hero)
    disguise_and_reckon_rmg.cooldown_for_hero[hero] = disguise_and_reckon_rmg.cooldown_in_days
    --ControlHeroCustomAbility(hero, CUSTOM_ABILITY_DISGUISE_AND_RECKON_ACTIVATE, CUSTOM_ABILITY_DISABLED)
    local owner = GetObjectOwner(hero)
    local heroes_to_show, h_n = {}, 0
    for player = PLAYER_1, PLAYER_8 do
        if (player ~= owner) and (GetPlayerState(player) == PLAYER_ACTIVE) and (GetPlayerTeam(player) ~= GetPlayerTeam(owner)) then
            local current_max_level = 0
            local current_hero_to_show = ""
            for i, c_hero in GetPlayerHeroes(player) do
                local level = GetHeroLevel(c_hero)
                if level > current_max_level then
                    current_max_level = level
                    current_hero_to_show = c_hero
                end
            end
            if current_hero_to_show ~= "" then
                h_n = h_n + 1
                heroes_to_show[h_n] = current_hero_to_show
            end
        end
    end
    if h_n > 0 then
        for i, c_hero in heroes_to_show do
            local object = GetHeroTown(c_hero) or c_hero
            startThread(Object.Show, owner, object)
        end
    end
end