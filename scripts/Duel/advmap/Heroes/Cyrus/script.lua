cyrus_spec_duel = {
    heroes = {"Cyrus1", "Cyrus2"},
    school_mapping = {
        [SKILL_DARK_MAGIC] = MAGIC_SCHOOL_DARK_WITH_MASS,
        [SKILL_LIGHT_MAGIC] = MAGIC_SCHOOL_LIGHT_WITH_MASS,
        [SKILL_DESTRUCTIVE_MAGIC] = MAGIC_SCHOOL_DESTRUCTIVE_WITH_EMP,
        [SKILL_SUMMONING_MAGIC] = MAGIC_SCHOOL_SUMMONING_WITH_EMP
    }
}

NewDayEvent.AddListener("btd_duel_cyrus_spec_new_day_listener",
function(day)
    if day == BTD_duel_day_sequence.prefight_day then
        for hero, alive_status in AdvMapHeroesInfo.alive_heroes do
            if hero and alive_status == HERO_CONDITION_ALIVE and contains(cyrus_spec_duel.heroes, hero) then
                local owner = GetObjectOwner(hero)
                local enemy_hero = GetPlayerHeroes(3 - owner)[0]
                for skill, school in cyrus_spec_duel.school_mapping do
                    if GetHeroSkillMastery(hero, skill) > 0 and GetHeroSkillMastery(enemy_hero, skill) then
                        for i, spell in spellsBySchools[school] do
                            if KnowHeroSpell(enemy_hero, spell) and (not KnowHeroSpell(hero, spell)) then
                                TeachHeroSpell(hero, spell)
                            end
                        end
                    end
                end
            end
        end
    end
end)