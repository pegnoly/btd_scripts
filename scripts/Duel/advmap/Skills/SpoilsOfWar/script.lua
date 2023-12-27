spoils_of_war_duel =
{
    heroes_active = {},
    art_for_hero = {}
}

AddHeroEvent.AddListener("btd_duel_spoils_of_war_listener",
function(hero)
    errorHook(function ()
        print("<color=red>Error: <color=green> SpoilsOfWar duel add hero.")
    end)
    spoils_of_war_duel.heroes_active[hero] = nil;
    startThread(
    function()
        while 1 do
            if IsHeroAlive(%hero) and GetDate(DAY) == BTD_duel_day_sequence.freeroam_day then
                if not spoils_of_war_duel.heroes_active[%hero] then
                    if HasHeroSkill(%hero, WIZARD_FEAT_SPOILS_OF_WAR) then
                        local art = Art.Distribution.RandomMajor()
                        spoils_of_war_duel.art_for_hero[%hero] = art
                        spoils_of_war_duel.heroes_active[%hero] = 1
                        Art.Distribution.Give(%hero, art)
                    end
                else
                    if not HasHeroSkill(%hero, WIZARD_FEAT_SPOILS_OF_WAR) then
                        spoils_of_war_duel.heroes_active[%hero] = nil
                    end;
                end;
            end;
            sleep();
        end;
    end);
end)