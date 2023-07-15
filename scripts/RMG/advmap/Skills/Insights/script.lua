insights = {
    active_for_hero = {}
}

AddHeroEvent.AddListener("BTD_RMG_insights_add_hero",
function(hero)
    insights.active_for_hero[hero] = nil
    startThread(
    function()
        while 1 do
            if IsHeroAlive(%hero) then
                if not insights.active_for_hero[%hero] then
                    if HasHeroSkill(%hero, RANGER_FEAT_INSIGHTS) then
                        insights.active_for_hero[%hero] = 1
                        local spells = Hero.SpellInfo.GetLearnableSpellsByLevel(%hero, 3, 1)
                        print("INSIGHTS: spells ", spells)
                        if spells then
                            local spell_to_learn = Random.FromTable(spells)
                            print("INSIGHTS: learning ", spell_to_learn)
                            Hero.SpellInfo.TeachSpell(%hero, spell_to_learn)
                        end
                    end
                end
            end
            sleep()
        end
    end)
end)