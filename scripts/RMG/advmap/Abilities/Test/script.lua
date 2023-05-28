AddHeroEvent.AddListener("BTD_RMG_ability_test", 
function(hero)
    ControlHeroCustomAbility(hero, 5, CUSTOM_ABILITY_ENABLED)
    ControlHeroCustomAbility(hero, 6, CUSTOM_ABILITY_ENABLED)
end)