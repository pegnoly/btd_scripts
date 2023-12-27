death_herald =
{
    morale_bonus = -1,
    affected_heroes_for_hero = {},
    base_distance = 20,
}

AddHeroEvent.AddListener('death_herald_add_hero_event',
function(hero)
  errorHook(function ()
      print("<color=red>Error: <color=green> HeraldOfDeath duel add hero.")
  end)
  startThread(
  function()
    death_herald.affected_heroes_for_hero[%hero] = {}
    while 1 do
      if IsHeroAlive(%hero) then
        local temp_name = GetHeroTown(%hero) or %hero
        for player = PLAYER_1, PLAYER_8 do
          if Player.IsActive(player) and (GetObjectOwner(%hero) ~= player) and (GetPlayerTeam(GetObjectOwner(%hero)) ~= GetPlayerTeam(player)) then
            for i, c_hero in GetPlayerHeroes(player) do
              if not death_herald.affected_heroes_for_hero[%hero][c_hero] then
                if HasHeroSkill(%hero, NECROMANCER_FEAT_HERALD_OF_DEATH) then
                  local dist = Object.Distance(c_hero, temp_name)
                  if dist and dist <= death_herald.base_distance then
                    death_herald.affected_heroes_for_hero[%hero][c_hero] = 1
                    GiveHeroBattleBonus(c_hero, HERO_BATTLE_BONUS_MORALE, death_herald.morale_bonus)
                  end
                end
              else
                if not HasHeroSkill(%hero, NECROMANCER_FEAT_HERALD_OF_DEATH) then
                  death_herald.affected_heroes_for_hero[%hero][c_hero] = nil
                  GiveHeroBattleBonus(c_hero, HERO_BATTLE_BONUS_MORALE, -death_herald.morale_bonus)
                end
                local dist = Object.Distance(c_hero, temp_name)
                if dist and dist > death_herald.base_distance then
                  death_herald.affected_heroes_for_hero[%hero][c_hero] = nil
                  GiveHeroBattleBonus(c_hero, HERO_BATTLE_BONUS_MORALE, -death_herald.morale_bonus)
                end
              end
            end
          end
        end
      end
      sleep()
    end
  end)
end)

death_herald_creatures =
{
    death_knight_count = 16,
}

NewDayEvent.AddListener("death_herald_new_day",
function(day)
    if day == BTD_duel_day_sequence.prefight_day then
        for hero, alive in AdvMapHeroesInfo.alive_heroes do
            if hero and alive and HasHeroSkill(hero, NECROMANCER_FEAT_HERALD_OF_DEATH) then
                startThread(Hero.CreatureInfo.Add, hero, CREATURE_DEATH_KNIGHT, death_herald_creatures.death_knight_count)
            end
        end
    end
end)