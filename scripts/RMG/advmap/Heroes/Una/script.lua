una_spec = {
    level_divisor = 5,
    rune_max_level = 4,
    heroes = {"Una"}
}

LevelUpEvent.AddListener("BTD_RMG_una_level_up",
function(hero)
    if contains(una_spec.heroes, hero) then
        if mod(GetHeroLevel(hero), una_spec.level_divisor) == 0 then
            local possible_runes, n = {}, 0
            for i, rune in spellsBySchools[MAGIC_SCHOOL_RUNIC] do
                if (not KnowHeroSpell(hero, rune)) and (Spell.Params.Level(rune) <= una_spec.rune_max_level) then
                    n = n + 1
                    possible_runes[n] = rune
                end
            end
            print("runes: ", possible_runes)
            if n > 0 then
                Hero.SpellInfo.TeachSpell(hero, Random.FromTable(possible_runes))
            end
        end
    end
end)