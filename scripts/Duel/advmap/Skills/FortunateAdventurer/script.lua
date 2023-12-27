fortunate_adventurer_duel =
{
  res_bonus = 1, 
  heroes_active = {},
  art_for_hero = {}
}

AddHeroEvent.AddListener("path_luck_prefight_event",
function(hero)
  errorHook(function ()
      print("<color=red>Error: <color=green> FortunateAdventurer duel add hero.")
  end)
  fortunate_adventurer_duel.heroes_active[hero] = nil;
  startThread(
    function()
      while 1 do
        if IsHeroAlive(%hero) and GetDate(DAY) == BTD_duel_day_sequence.freeroam_day then
          if not fortunate_adventurer_duel.heroes_active[%hero] then
            if HasHeroSkill(%hero, PERK_FORTUNATE_ADVENTURER) then
              fortunate_adventurer_duel.heroes_active[%hero] = 1;
              for res = WOOD, GEM do
                Resource.Change(%hero, res, fortunate_adventurer_duel.res_bonus)
                sleep(1);
              end
              local art = Art.Distribution.RandomMinor()
              Art.Distribution.Give(%hero, art)
              fortunate_adventurer_duel.art_for_hero[%hero] = art;
            end
          else
            if not HasHeroSkill(%hero, PERK_FORTUNATE_ADVENTURER) then
              fortunate_adventurer_duel.heroes_active[%hero] = nil
            end;
          end;
        end;
        sleep();
      end;
    end
  );
end)