lord_of_undead =
{
  ini_bonus = 1, -- число инициативы, которое дает перк
  sp_bonus = 1,
  heroes_active = {},
}

AddHeroEvent.AddListener("lord_of_undead_add_hero",
function(hero)
  lord_of_undead.heroes_active[hero] = nil
  startThread(
  function()
    while 1 do
      if IsHeroAlive(%hero) then
        if not lord_of_undead.heroes_active[%hero] then
          if HasHeroSkill(%hero, NECROMANCER_FEAT_LORD_OF_UNDEAD) then
            lord_of_undead.heroes_active[%hero] = 1
            GiveHeroBattleBonus(%hero, HERO_BATTLE_BONUS_INITIATIVE, lord_of_undead.ini_bonus)
            ChangeHeroStat(%hero, STAT_SPELL_POWER, lord_of_undead.sp_bonus)
          end
        else
          if not HasHeroSkill(%hero, NECROMANCER_FEAT_LORD_OF_UNDEAD) then
            lord_of_undead.heroes_active[%hero] = nil
            GiveHeroBattleBonus(%hero, HERO_BATTLE_BONUS_INITIATIVE, -lord_of_undead.ini_bonus)
            ChangeHeroStat(%hero, STAT_SPELL_POWER, -lord_of_undead.sp_bonus)
          end
        end
      end
      sleep()
    end
  end)
end)

-- добавил армию при тп на арену
NewDayEvent.AddListener("lord_of_undead_new_day",
function(day)
  if day == BTD_FIGHT_DAY then
    for hero, alive in AdvMapHeroesInfo.alive_heroes do
      if hero and alive and HasHeroSkill(hero, NECROMANCER_FEAT_LORD_OF_UNDEAD) then
        for tier = 1, 7 do
          local creature = TIER_TABLES[TOWN_NECROMANCY][tier][1]
          startThread(Hero.CreatureInfo.DefaultGrow, hero, TOWN_NECROMANCY, tier, Creature.Params.Grow(creature))
        end
      end
    end
  end
end)

CombatResultsEvent.AddListener("lord_of_undead_combat_result",
function(fight_id)
    local winner = GetSavedCombatArmyHero(fight_id, 1)
    if winner and lord_of_undead.heroes_active[winner] then
        GiveHeroBattleBonus(winner, HERO_BATTLE_BONUS_INITIATIVE, lord_of_undead.ini_bonus)
    end
end)

RespawnHeroEvent.AddListener("lord_of_undead_respawn_hero",
function(hero)
    if lord_of_undead.heroes_active[hero] then
        GiveHeroBattleBonus(hero, HERO_BATTLE_BONUS_INITIATIVE, lord_of_undead.ini_bonus)
    end
end)