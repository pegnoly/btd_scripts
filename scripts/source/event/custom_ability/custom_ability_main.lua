CUSTOM_ABILITY_ARTIFACT = 1
CUSTOM_ABILITY_HERO = 2
CUSTOM_ABILITY_TOWN = 3

CustomAbility =
{
    callbacks = {},

    callbacks_for_hero = {
        [CUSTOM_ABILITY_ARTIFACT] = {},
        [CUSTOM_ABILITY_HERO] = {},
        [CUSTOM_ABILITY_TOWN] = {}
    },

    enabled_for_hero = {
        [CUSTOM_ABILITY_ARTIFACT] = {},
        [CUSTOM_ABILITY_HERO] = {},
        [CUSTOM_ABILITY_TOWN] = {}
    },

    Init =
    function()
        Trigger(CUSTOM_ABILITY_TRIGGER, "CustomAbility.Run")
    end,

    Run = 
    function(hero, ability_id)
        if ability_id == CUSTOM_ABILITY_4 then
            startThread(CustomAbility.callbacks[CUSTOM_ABILITY_4], hero)
            return
        end
        for callback, active in CustomAbility.callbacks_for_hero[ability_id][hero] do
            local info = CustomAbility.callbacks[callback]
            local question
            if info.question then
                question = info.question
            elseif info.question_func then
                question = info.question_func(hero)
            end
            if MCCS_QuestionBoxForPlayers(GetObjectOwner(hero), question) then
                startThread(info.func, hero)
                break
            end
        end
    end
}