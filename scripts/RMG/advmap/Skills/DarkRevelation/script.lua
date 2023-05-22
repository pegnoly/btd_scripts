dark_revelation =
{
  active_for_hero = {},
  exp_per_five_lvl = 2500,
}

AddHeroEvent.AddListener("BTD_RMG_dark_revelation",
function(hero)
  startThread(
     function()
        while 1 do
          if IsHeroAlive(%hero) and HasHeroSkill(%hero, WARLOCK_FEAT_DARK_REVELATION) then
            if dark_revelation.active_for_hero[%hero] == nil then
              dark_revelation.active_for_hero[%hero] = not nil;

              local needExp = floor(GetHeroLevel(%hero) / 5) * dark_revelation.exp_per_five_lvl;

              Hero.Stats.Change(%hero, STAT_EXPERIENCE, needExp);
            end;
          end;
          
          sleep()
        end;
     end
  )
end)