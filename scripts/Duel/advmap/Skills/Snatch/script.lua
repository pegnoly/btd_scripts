snatch_duel =
{
    gold_bonus = 5000,
    gold_by_player = {},
    art_info_by_hero = {},
    heroes_active = {}
}

AddHeroEvent.AddListener(snatch_prefight_event",
function(hero)
    snatch.heroes_active[hero] = nil;
    startThread(
        function()
        while 1 do
            if IsHeroAlive(%hero) and GetDate(DAY) == BTD_duel_day_sequence.freeroam_day then
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

MapLoadingEvent.AddListener("btd_duel_snatch_init_listener",
function()
    while 1 do
        
    end  
end)