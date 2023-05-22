feat_death =
{
  active_for_hero = {},
  offence_bonus = 8,
  restore_bonus_every_level = 5,
}

function featDeathBaff(hero, cycleIndex)
  GiveHeroBattleBonus(hero, HERO_BATTLE_BONUS_ATTACK, feat_death.offence_bonus);
  ChangeHeroStat(hero, STAT_MOVE_POINTS, 250)
  feat_death.active_for_hero[hero] = cycleIndex;
end;

LevelUpEvent.AddListener("BTD_RMG_feat_death_level_up",
function(hero)
    if HasHeroSkill(hero, NECROMANCER_FEAT_DEATH_TREAD) then
        local cycleIndex = floor(GetHeroLevel(hero) / feat_death.restore_bonus_every_level);

        if feat_death.active_for_hero[hero] == nil then
            featDeathBaff(hero, cycleIndex);
        end;

        if feat_death.active_for_hero[hero] ~= nil and feat_death.active_for_hero[hero] < cycleIndex then
            featDeathBaff(hero, cycleIndex);
        end;
    end;
end)