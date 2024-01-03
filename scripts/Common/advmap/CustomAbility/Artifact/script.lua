while not CustomAbility and not CUSTOM_ABILITY_ARTIFACT do
    sleep()
end

AddHeroEvent.AddListener("btd_common_artifact_custom_add_hero_listener",
function(hero)
    CustomAbility.callbacks_for_hero[CUSTOM_ABILITY_ARTIFACT][hero] = {}
    CustomAbility.enabled_for_hero[CUSTOM_ABILITY_ARTIFACT][hero] = nil
    startThread(
    function()
        while 1 do
            if IsHeroAlive(%hero) then
                if not CustomAbility.enabled_for_hero[CUSTOM_ABILITY_ARTIFACT][%hero] then
                    if len(CustomAbility.callbacks_for_hero[CUSTOM_ABILITY_ARTIFACT][%hero]) > 0 then
                        CustomAbility.enabled_for_hero[CUSTOM_ABILITY_ARTIFACT][%hero] = 1
                        ControlHeroCustomAbility(%hero, CUSTOM_ABILITY_ARTIFACT, CUSTOM_ABILITY_ENABLED)
                    end
                else
                    if len(CustomAbility.callbacks_for_hero[CUSTOM_ABILITY_ARTIFACT][%hero]) == 0 then
                        CustomAbility.enabled_for_hero[CUSTOM_ABILITY_ARTIFACT][%hero] = nil
                        ControlHeroCustomAbility(%hero, CUSTOM_ABILITY_ARTIFACT, CUSTOM_ABILITY_NOT_PRESENT)
                    end
                end
            end
            sleep()
        end 
    end)
end)