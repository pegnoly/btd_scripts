maahir_spec =
{
  path = "/scripts/NHF/Academy/",
  res_adds = {[0] = 20; 20, 10, 10, 10, 10},
  heroes = {"Maahir1", "Maahir2"}
}

NewDayEvent.AddListener("NHF_maahir_new_day_event",
function(day)
  if day == BTD_SPECIAL_DAY then
    for hero, alive in AdvMapHeroesInfo.alive_heroes do
      if hero and alive and contains(maahir_spec.heroes, hero) then
        startThread(MCCS_MessageBoxForPlayers, GetObjectOwner(hero), maahir_spec.path.."maahir_msg.txt")
        for res, amount in maahir_spec.res_adds do
          Resource.Change(hero, res, amount)
          sleep(5)
        end
      end
    end
  end
end)

