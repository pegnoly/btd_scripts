navigation_rmg =
{
  active_for_hero = {},
  path = "/scripts/RMG/advmap/Skills/Navigation/",
  stat_amount = 2,
  map_file_to_stat = {
    [STAT_ATTACK] = 'attack',
    [STAT_DEFENCE] = 'defence',
    [STAT_SPELL_POWER] = 'spell_power',
    [STAT_KNOWLEDGE] = 'knowledge',
  },
}

AddHeroEvent.AddListener("BTD_rmg_navigation_add_hero_event",
function(hero)
  navigation_rmg.active_for_hero[hero] = nil
  startThread(
  function()
    while 1 do
      if IsHeroAlive(%hero) then
        if not navigation_rmg.active_for_hero[%hero] then
          if HasHeroSkill(%hero, PERK_NAVIGATION) then
            for statId, halfFileName in navigation_rmg.map_file_to_stat do
              local isAgreed = MCCS_QuestionBoxForPlayers(GetObjectOwner(%hero), { navigation_rmg.path.."question_select_"..halfFileName..".txt"; amount=navigation_rmg.stat_amount });
              
              if isAgreed then
                Hero.Stats.Change(%hero, statId, navigation_rmg.stat_amount)
                navigation_rmg.active_for_hero[%hero] = statId
                
                break;
              end;

              -- Если отказался от СП - выдаем ему знание
              if statId == STAT_SPELL_POWER then
                Hero.Stats.Change(%hero, STAT_KNOWLEDGE, navigation_rmg.stat_amount)
                navigation_rmg.active_for_hero[%hero] = STAT_KNOWLEDGE
                
                break;
              end;
            end;
          end
        else
          if not HasHeroSkill(%hero, PERK_NAVIGATION) then
            Hero.Stats.Change(%hero, navigation_rmg.active_for_hero[%hero], -navigation_rmg.stat_amount)
          
            navigation_rmg.active_for_hero[%hero] = nil
          end
        end
      end
      sleep()
    end
  end)
end)