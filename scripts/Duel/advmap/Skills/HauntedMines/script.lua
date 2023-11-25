haunted_mines =
{
  manes_count = 75, 
  
  up =
  function(hero)
    startThread(Hero.CreatureInfo.DefaultGrow(hero, TOWN_NECROMANCY, 3, haunted_mines.manes_count))
  end,
}

NewDayEvent.AddListener("btd_haunted_mines_event",
function(day)
    if day == BTD_FIGHT_DAY then
        for hero, alive in AdvMapHeroesInfo.alive_heroes do
            if hero and alive and HasHeroSkill(hero, NECROMANCER_FEAT_HAUNT_MINE) then
                startThread(haunted_mines.up, hero)
            end
        end
    end
end)