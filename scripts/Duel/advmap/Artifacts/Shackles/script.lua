function ApplyShacklesToOthers(heroFrom)
    for hero, alive_status in AdvMapHeroesInfo.alive_heroes do
        if hero and alive_status == HERO_CONDITION_ALIVE and hero ~= heroFrom then
            GiveHeroBattleBonus(hero, HERO_BATTLE_BONUS_SPEED, -1)
        end 
    end
end
  
NewDayEvent.AddListener("btd_duel_shackles_new_day_listener",
function(day)
    if day == BTD_duel_day_sequence.fight_day then 
        for hero, alive_status in AdvMapHeroesInfo.alive_heroes do
            if hero and alive_status == HERO_CONDITION_ALIVE and 
                HasArtefact(hero, ARTIFACT_SHACKLES_OF_WAR, 1) and 
                not HasHeroSkill(hero, NECROMANCER_FEAT_DEATH_TREAD) and 
                not HasHeroSkill(hero, RANGER_FEAT_STORM_WIND) then
                ApplyShacklesToOthers(hero)
            end 
        end
    end
end)
  