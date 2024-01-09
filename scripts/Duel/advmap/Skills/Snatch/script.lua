snatch_duel = {
    gold_bonus = 5000,
    gold_by_player = {},
    art_info_by_hero = {},
    active_for_hero = {},
}

AddHeroEvent.AddListener("btd_duel_snatch_add_hero_listener",
function(hero)
    snatch_duel.art_info_by_hero[hero] = {}
    startThread(
    function()
        while GetDate(DAY) ~= BTD_duel_day_sequence.freeroam_day do
            sleep()
        end
        --
        if not IsHeroAlive(%hero) then
            return
        end
        local player = GetObjectOwner(%hero)
        snatch_duel.gold_by_player[player] = GetPlayerResource(player, GOLD)
        for art = 1, 126 do
            snatch_duel.art_info_by_hero[%hero][art] = GetHeroArtifactsCount(%hero, art)
        end
        while 1 do
            local gold = GetPlayerResource(player, GOLD)
            if gold < snatch_duel.gold_by_player[player] and HasHeroSkill(%hero, HERO_SKILL_SNATCH) then
                local diff = snatch_duel.gold_by_player[player] - gold
                for art = 1, 126 do
                    if GetHeroArtifactsCount(%hero, art) > snatch_duel.art_info_by_hero[%hero][art] then
                        if diff == Art.Params.Cost(art) then
                            Resource.Change(%hero, GOLD, diff * 0.25)
                        end
                        snatch_duel.art_info_by_hero[%hero][art] = GetHeroArtifactsCount(%hero, art)
                    end
                end
            end
            snatch_duel.gold_by_player[player] = GetPlayerResource(player, GOLD)
            for art = 1, 126 do
                snatch_duel.art_info_by_hero[%hero][art] = GetHeroArtifactsCount(%hero, art)
            end
            sleep()
        end
    end)
end)

AddHeroEvent.AddListener("btd_duel_snatch_add_hero_gold_listener",
function(hero)
    snatch_duel.active_for_hero[hero] = nil
    startThread(
    function()
        while GetDate(DAY) ~= BTD_duel_day_sequence.freeroam_day do
            sleep()
        end
        while 1 do
            if IsHeroAlive(%hero) then
                if not snatch_duel.active_for_hero[%hero] then
                    if HasHeroSkill(%hero, HERO_SKILL_SNATCH) then
                        snatch_duel.active_for_hero[%hero] = 1
                        Resource.Change(%hero, GOLD, snatch_duel.gold_bonus)
                        return
                    end
                else
                    if not HasHeroSkill(%hero, HERO_SKILL_SNATCH) then
                        snatch_duel.active_for_hero[%hero] = nil
                    end
                end
            end
            sleep()
        end
    end)
end)