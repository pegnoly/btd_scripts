elleshar_spec =
{
  path = "/scripts/NHF/Preserve/",
  heroes = {"Elleshar1", "Elleshar2"},
  additional_levels = 1
}

NewDayEvent.AddListener('NHF_elleshar_new_day_event',
function(day)
  if day == BTD_SPECIAL_DAY then
    for hero, alive in AdvMapHeroesInfo.alive_heroes do
      if hero and alive and contains(elleshar_spec.heroes, hero) then
        startThread(MCCS_MessageBoxForPlayers, GetObjectOwner(hero), elleshar_spec.path.."elleshar_lvl_up_msg.txt")
        for i = 1, elleshar_spec.additional_levels do
          LevelUpHero(hero)
        end
      end
    end
  end
end)