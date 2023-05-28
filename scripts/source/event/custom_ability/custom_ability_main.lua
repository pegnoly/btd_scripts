CustomAbility =
{
    callbacks = {},

    Init =
    function()
        Trigger(CUSTOM_ABILITY_TRIGGER, "CustomAbility.Run")
    end,

    Run = 
    function(hero, ability_id)
        startThread(CustomAbility.callbacks[ability_id], hero)
    end
}