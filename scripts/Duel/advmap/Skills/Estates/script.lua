estates =
{
  bonus_gold = 3750,
  heroes_active = {}
}

AddHeroEvent.AddListener("estates_fight_event",
function(hero)
  estates.heroes_active[hero] = nil;

  startThread(
    function()
      while 1 do
        if IsHeroAlive(%hero) and GetDate(DAY) == BTD_FREE_ROAM_DAY then
          if not estates.heroes_active[%hero] then
            if HasHeroSkill(%hero, PERK_ESTATES) then
              estates.heroes_active[%hero] = 1
              Resource.Change(%hero, GOLD, estates.bonus_gold);
            end
          else
            if not HasHeroSkill(%hero, PERK_ESTATES) then
              estates.heroes_active[%hero] = nil
            end;
          end;
        end;
        sleep();
      end;
    end
  );
end)