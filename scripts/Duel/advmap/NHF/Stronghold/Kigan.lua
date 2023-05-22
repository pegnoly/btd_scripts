kigan_spec =
{
  path = "/scripts/NHF/Stronghold/",
  heroes = {"Hero91", "Hero92"},
  grow = 150 + random(21)
}

NewDayEvent.AddListener("NHF_kigan_spec_new_day_event",
function(day)
  if day == BTD_SPECIAL_DAY then
    for hero, alive in AdvMapHeroesInfo.alive_heroes do
      if hero and alive and contains(kigan_spec.heroes, hero) then
        startThread(MCCS_MessageBoxForPlayers, GetObjectOwner(hero), kigan_spec.path.."kigan_grow_msg.txt")
        startThread(Hero.CreatureInfo.DefaultGrow, hero, TOWN_STRONGHOLD, 1, kigan_spec.grow)
      end
    end
  end
end)