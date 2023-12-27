HERO_SKILL_BLOODY_MANA = 224

bloody_mana = {
    active_for_hero = {},
}

AddHeroEvent.AddListener("BTD_common_bloody_mana_add_hero",
function(hero)
    bloody_mana.active_for_hero[hero] = nil
    if Hero.Params.Town(hero) ~= TOWN_STRONGHOLD then
        return
    end
    startThread(
    function()
        while 1 do
            if IsHeroAlive(%hero) then
                if not bloody_mana.active_for_hero[%hero] then
                    if HasHeroSkill(%hero, HERO_SKILL_BLOODY_MANA) then
                        bloody_mana.active_for_hero[%hero] = 1
                        consoleCmd("@SetGameVar('"..%hero.."_BLOODY_MANA', '1')")
                    end
                else
                    if not HasHeroSkill(%hero, HERO_SKILL_BLOODY_MANA) then
                        bloody_mana.active_for_hero[%hero] = nil
                        consoleCmd("@SetGameVar('"..%hero.."_BLOODY_MANA', '')")
                    end
                end
            end
            sleep()
        end 
    end)
end)

RespawnHeroEvent.AddListener("BTD_common_bloody_mana_respawn_hero_event",
function(hero)
    if HasHeroSkill(hero, HERO_SKILL_BLOODY_MANA) then
        consoleCmd("@SetGameVar('"..hero.."_BLOODY_MANA', '1')")
    end
end)

-- CombatResultsEvent.AddListener("BTD_common_bloody_mana_combat_result",
-- function(fight_id)
--     for side = 0, 1 do
--         startThread(BloodySacrifice_RestoreMana, GetSavedCombatArmyHero(fight_id, side))
--     end
-- end)

-- function BloodySacrifice_RestoreMana(hero)
--     if hero and HasHeroSkill(hero, HERO_SKILL_BLOODY_MANA) then
--         local hero_possible_mana = GetHeroStat(hero, STAT_KNOWLEDGE) * (HasHeroSkill(hero, HERO_SKILL_BARBARIAN_INTELLIGENCE) and 15 or 10)
--         local hero_current_mana = GetHeroStat(hero, STAT_MANA_POINTS)
--         local diff = hero_current_mana - hero_possible_mana
--         if diff > 0 then
--             ChangeHeroStat(hero, STAT_MANA_POINTS, -diff)
--         end
--     end
-- end

CombatConnection.combat_scripts_paths['bloody_mana'] = '/scripts/Common/combat/Skills/BloodyMana/script.lua'