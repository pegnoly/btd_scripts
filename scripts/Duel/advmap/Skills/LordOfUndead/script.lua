lord_of_undead_duel =
{
    know_amount = 1,
    heroes_active = {}
}

AddHeroEvent.AddListener("btd_duel_lord_of_undead_add_hero_listener",
function(hero)
    errorHook(function ()
        print("<color=red>Error: <color=green> LordOfUndead duel add hero.")
    end)
    if Hero.Params.Class(hero) ~= HERO_CLASS_NECROMANCER then
        return
    end
    lord_of_undead_duel.heroes_active[hero] = nil
    startThread(
    function()
        while 1 do
            if IsHeroAlive(%hero) then
                if not lord_of_undead_duel.heroes_active[%hero] then
                    if HasHeroSkill(%hero, NECROMANCER_FEAT_LORD_OF_UNDEAD) then
                      lord_of_undead_duel.heroes_active[%hero] = 1
                        ChangeHeroStat(%hero, STAT_KNOWLEDGE, lord_of_undead_duel.know_amount)
                    end
                else
                    if not HasHeroSkill(%hero, NECROMANCER_FEAT_LORD_OF_UNDEAD) then
                      lord_of_undead_duel.heroes_active[%hero] = nil
                        ChangeHeroStat(%hero, STAT_KNOWLEDGE, -lord_of_undead_duel.know_amount)
                    end
                end
            end
            sleep()
        end
    end)
end)

-- добавил армию при тп на арену
NewDayEvent.AddListener("btd_duel_lord_of_undead_new_day_listener",
function(day)
    if day == BTD_duel_day_sequence.prefight_day then
        for hero, alive in AdvMapHeroesInfo.alive_heroes do
            if hero and alive and HasHeroSkill(hero, NECROMANCER_FEAT_LORD_OF_UNDEAD) then
                for tier = 1, 7 do
                    local creature = TIER_TABLES[TOWN_NECROMANCY][tier][1]
                    startThread(Hero.CreatureInfo.DefaultGrow, hero, TOWN_NECROMANCY, tier, Creature.Params.Grow(creature))
                end
            end
        end
    end
end)