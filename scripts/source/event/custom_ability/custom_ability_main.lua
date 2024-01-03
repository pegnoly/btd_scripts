CUSTOM_ABILITY_ARTIFACT = 1

CustomAbility =
{
    callbacks = {},

    callbacks_for_hero = {
        [CUSTOM_ABILITY_ARTIFACT] = {}
    },

    enabled_for_hero = {
        [CUSTOM_ABILITY_ARTIFACT] = {}
    },

    Init =
    function()
        Trigger(CUSTOM_ABILITY_TRIGGER, "CustomAbility.Run")
    end,

    Run = 
    function(hero, ability_id)
        for callback, active in CustomAbility.callbacks_for_hero[ability_id][hero] do
            local info = CustomAbility.callbacks[callback]
            if MCCS_QuestionBoxForPlayers(GetObjectOwner(hero), info.question) then
                startThread(info.func, hero)
                break
            end
        end
    end
}