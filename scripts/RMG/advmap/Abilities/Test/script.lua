AddHeroEvent.AddListener("BTD_RMG_ability_test", 
function(hero)
    ControlHeroCustomAbility(hero, 3, CUSTOM_ABILITY_ENABLED)
    ControlHeroCustomAbility(hero, 4, CUSTOM_ABILITY_ENABLED)
end)

CustomAbility.callbacks[5] = 
function(hero)
    print("custom 5")
end

CustomAbility.callbacks[6] =
function(hero)
    print("custom 6")
end