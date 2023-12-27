insights = {
    active_for_hero = {},
    spells_count = 2
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
                            local spells_count = len(spells) > 1 and insights.spells_count or 1
                            print("INSIGHTS: spells count", spells_count)
                            local learned = 0
                            local already_learned = {}
                            while learned ~= spells_count do
                                local spell_to_learn = Random.FromTable(spells)
                                if not already_learned[spell_to_learn] then
                                    learned = learned + 1
                                    already_learned[spell_to_learn] = 1
                                    print("INSIGHTS: learning ", spell_to_learn)
                                    Hero.SpellInfo.TeachSpell(%hero, spell_to_learn)
                                else
                                    sleep()
                                end    
                            end
                        end
                    end
                end
            end
            sleep()
        end
    end)
end)