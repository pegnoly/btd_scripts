snatch =
{
  gold_bonus = 10000,
  heroes_active = {}
}

AddHeroEvent.AddListener(snatch_prefight_event",
function(hero)
    snatch.heroes_active[hero] = nil;
    startThread(
        function()
        while 1 do
            if IsHeroAlive(%hero) and GetDate(DAY) == BTD_FREE_ROAM_DAY then
                if not marodeur.heroes_active[%hero] then
                    if HasHeroSkill(%hero, HERO_SKILL_SNATCH) then
                        snatch.heroes_active[%hero] = 1
                        Resource.Change(%hero, GOLD, snatch.gold_bonus)
                    end
                else
                    if not HasHeroSkill(%hero, HERO_SKILL_SNATCH) then
                        snatch.heroes_active[%hero] = nil
                    end
                end
            end
            sleep()
        end
     end)
end)