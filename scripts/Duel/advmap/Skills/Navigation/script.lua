AddHeroEvent.AddListener("BTD_duel_navigation_add_hero",
function(hero)
    errorHook(function ()
        print("<color=red>Error: <color=green> Navigation duel add hero.")
    end)
    navigation_common.stat_for_hero[hero] = nil
    startThread(
    function()
        while GetDate(DAY) ~= BTD_duel_day_sequence.freeroam_day do
            sleep()
        end
        while 1 do
            if IsHeroAlive(%hero) then
                if not navigation_common.stat_for_hero[%hero] then
                    if HasHeroSkill(%hero, PERK_NAVIGATION) then
                        CustomAbility.callbacks_for_hero[CUSTOM_ABILITY_HERO][%hero]["navigation"] = nil
                    end
                else
                    if not HasHeroSkill(%hero, PERK_NAVIGATION) then
                        Hero.Stats.Change(%hero, navigation_common.stat_for_hero[%hero], -navigation_common.stat_amount)
                        navigation_common.stat_for_hero[%hero] = nil
                        --ControlHeroCustomAbility(%hero, CUSTOM_ABILITY_NAVIGATION, CUSTOM_ABILITY_DISABLED)
                    end
                end
            end
            sleep()
        end
    end)
end)