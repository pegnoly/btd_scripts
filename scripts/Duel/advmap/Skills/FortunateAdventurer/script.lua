path_luck =
{
  res_bonus = 1, 
  heroes_active = {},
  art_for_hero = {}
}

AddHeroEvent.AddListener("path_luck_prefight_event",
function(hero)
  path_luck.heroes_active[hero] = nil;
  startThread(
    function()
      while 1 do
        if IsHeroAlive(%hero) and GetDate(DAY) == BTD_FREE_ROAM_DAY then
          if not path_luck.heroes_active[%hero] then
            if HasHeroSkill(%hero, PERK_FORTUNATE_ADVENTURER) then
              path_luck.heroes_active[%hero] = 1;
              for res = WOOD, GEM do
                Resource.Change(%hero, res, path_luck.res_bonus)
                sleep(1);
              end
              local art = Art.Distribution.RandomMinor()
              Art.Distribution.Give(%hero, art)
              path_luck.art_for_hero[%hero] = art;
            end
          else
            if not HasHeroSkill(%hero, PERK_FORTUNATE_ADVENTURER) then
              path_luck.heroes_active[%hero] = nil
            end;
          end;
        end;
        sleep();
      end;
    end
  );
end)