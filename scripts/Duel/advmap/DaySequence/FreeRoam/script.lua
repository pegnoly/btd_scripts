NewDayEvent.AddListener('btd_duel_free_roam_event',
function(day)
  if day == BTD_FREE_ROAM_DAY then
    free_roam_deploy = {
                        [1]={132, 56, 0},
                        [2]={21, 44, 0},}
    for player = PLAYER_1, PLAYER_2 do
      local hero = GetPlayerHeroes(player)[0]
      -- Перенос с первой локи на вторую
      SetObjectPosition(hero, free_roam_deploy[player][1], free_roam_deploy[player][2], free_roam_deploy[player][3], 0)
      for n, town in GetObjectNamesByType('TOWN') do
        if GetObjectOwner(town) == GetObjectOwner(hero) then
          MakeHeroInteractWithObject(hero, town)
        end
      end
    end
  end
end)