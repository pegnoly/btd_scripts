CombatResultsEvent.AddListener("btd_restore_troops_event",
function(fight_id)
  local winner = GetSavedCombatArmyHero(fight_id, 1)
  if winner then
    for i = 0, GetSavedCombatArmyCreaturesCount(fight_id, 1) - 1 do
      local creature, count, died = GetSavedCombatArmyCreatureInfo(fight_id, 1, i)
      if died > 0 then
        startThread(Hero.CreatureInfo.Add, winner, creature, died)
      end
    end
  end
end)