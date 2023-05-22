logistics_spec =
{
  heroes = {"Grok1", "Heam1", "Hero21", "Brem1", "Grok2", "Heam2", "Hero22", "Brem2"},
  gold_bonus = 6000
}

NewDayEvent.AddListener("btd_logistics_new_day_event",
function(day)
  if day == BTD_SPECIAL_DAY then
    for hero, alive in AdvMapHeroesInfo.alive_heroes do
      if hero and alive and contains(logistics_spec.heroes, hero) then
        Resource.Change(hero, GOLD, logistics_spec.gold_bonus)
        startThread(MCCS_MessageBoxForPlayers, GetObjectOwner(hero), {"scripts/NHF/Common/logistics_msg.txt"; bonus = logistics_spec.gold_bonus})
      end
    end
  end
end)