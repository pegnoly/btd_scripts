valeria_spec = {
    heroes = {"RedHeavenHero03"},
    spells_map_for_hero = {},
}

AddHeroEvent.AddListener("BTD_RMG_valeria_spec_add_hero", 
function(hero)
    if contains(valeria_spec.heroes, hero) then
        valeria_spec.spells_map_for_hero[hero] = {
            [SPELL_SLOW] = SPELL_MASS_SLOW,
            [SPELL_FORGETFULNESS] = SPELL_MASS_FORGETFULNESS,
            [SPELL_CURSE] = SPELL_MASS_CURSE,
            [SPELL_WEAKNESS] = SPELL_MASS_WEAKNESS,
            [SPELL_PLAGUE] = SPELL_MASS_PLAGUE,
            [SPELL_DISRUPTING_RAY] = SPELL_MASS_DISRUPTING_RAY
        }
        startThread(
        function()
            while 1 do
                if IsHeroAlive(%hero) then
                    for spell, unknown in valeria_spec.spells_map_for_hero[%hero] do
                        if unknown and KnowHeroSpell(%hero, spell) then
                            TeachHeroSpell(%hero, unknown)
                            valeria_spec.spells_map_for_hero[%hero][spell] = nil
                        end
                    end
                end
                sleep()
            end 
        end)
    end
end)