spoils_of_war =
{
  heroes_active = {},
  art_for_hero = {}
}

AddHeroEvent.AddListener("trophy_fight_event",
function(hero)
    spoils_of_war.heroes_active[hero] = nil;
    startThread(
    function()
        while 1 do
            if IsHeroAlive(%hero) and GetDate(DAY) == BTD_FREE_ROAM_DAY then
                if not spoils_of_war.heroes_active[%hero] then
                    if HasHeroSkill(%hero, WIZARD_FEAT_SPOILS_OF_WAR) then
                        local art = Art.Distribution.RandomMajor()
                        spoils_of_war.art_for_hero[%hero] = art
                        spoils_of_war.heroes_active[%hero] = 1
                        Art.Distribution.Give(%hero, art)
                    end
                else
                    if not HasHeroSkill(%hero, WIZARD_FEAT_SPOILS_OF_WAR) then
                        spoils_of_war.heroes_active[%hero] = nil
                    end;
                end;
            end;
            sleep();
        end;
    end);
end)