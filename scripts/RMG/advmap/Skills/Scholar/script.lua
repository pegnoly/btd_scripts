scholar_rmg = {
    active_for_hero = {},
    dolmens_touched = {},
    additional_exp = 1000
}

AddHeroEvent.AddListener("BTD_rmg_scholar_add_hero",
function(hero)
    scholar_rmg.active_for_hero[hero] = nil
    startThread(
    function()
        while 1 do
            if IsHeroAlive(%hero) then
                if not scholar_rmg.active_for_hero[%hero] then
                    if HasHeroSkill(%hero, PERK_SCHOLAR) then
                        scholar_rmg.active_for_hero[%hero] = 1
                    end
                else
                    if not HasHeroSkill(%hero, PERK_SCHOLAR) then
                        scholar_rmg.active_for_hero[%hero] = nil
                    end
                end
            end
            sleep()
        end
    end)
end)

MapLoadingEvent.AddListener("BTD_rmg_scholar_init",
function()
    for i, dolmen in GetObjectNamesByType('BUILDING_LEARNING_STONE') do 
        Touch.SetTrigger(dolmen)
        Touch.SetFunction(dolmen, "_touch",
        function(hero, object)
            if not scholar_rmg.dolmens_touched[object] then
                scholar_rmg.dolmens_touched[object] = 1
                if HasHeroSkill(hero, PERK_SCHOLAR) or HasHeroSkill(hero, HERO_SKILL_WARCRY_LEARNING) then
                    GiveExp(hero, scholar_rmg.additional_exp)
                end
            end
        end)
    end
end)