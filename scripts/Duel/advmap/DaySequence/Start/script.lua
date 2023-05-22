NewDayEvent.AddListener('btd_duel_remove_mp_event',
function(day)
  if day == BTD_START_DAY then
    startThread(
    function()
      while GetDate(DAY) < BTD_HERO_CHOISE_DAY do
        for player = PLAYER_1, PLAYER_2 do
          for n, hero in GetPlayerHeroes(player) do
            local mp = GetHeroStat(hero, STAT_MOVE_POINTS)
            ChangeHeroStat(hero, STAT_MOVE_POINTS, -mp)
          end
        end
        sleep()
      end
    end)
  end
end)