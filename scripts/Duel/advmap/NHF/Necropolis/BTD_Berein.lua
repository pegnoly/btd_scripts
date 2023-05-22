berein_spec =
{
  heroes = {"Berein1", "Berein2",},
  additional_creatures = 200,
  path = "/scripts/NHF/Necropolis/"
}

NewDayEvent.AddListener('NHF_berein_new_day_event',
function(day)
  if day == BTD_SPECIAL_DAY then
    for hero, alive in AdvMapHeroesInfo.alive_heroes do
      if hero and alive and contains(berein_spec.heroes, hero) then
        startThread(MCCS_MessageBoxForPlayers, GetObjectOwner(hero), berein_spec.path.."berein_creatures_add.txt")
        startThread(Hero.CreatureInfo.DefaultGrow, hero, TOWN_NECROMANCY, 1, berein_spec.additional_creatures)
      end
    end
  end
end)