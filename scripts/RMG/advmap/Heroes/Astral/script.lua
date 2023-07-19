astral_spec_rmg = {
    heroes = {"Astral"},
    mana_per_level = 1,
    path = "/scripts/RMG/advmap/Heroes/Astral/"
}

CombatResultsEvent.AddListener("BTD_RMG_astral_combat_result",
function(fight_id)
    local winner = GetSavedCombatArmyHero(fight_id, 1)
    if winner and contains(astral_spec_rmg.heroes, winner) then
        local mana_to_restore = GetHeroLevel(winner) * astral_spec_rmg.mana_per_level
        local current_mana = GetHeroStat(winner, STAT_MANA_POINTS)
        local max_mana = GetHeroStat(winner, STAT_KNOWLEDGE) * 
                (10 + (HasHeroSkill(winner, PERK_INTELLIGENCE) and 5 or 0)) 
        local mana_diff = max_mana - current_mana
        if mana_diff < mana_to_restore then
            mana_to_restore = mana_diff
        end
        ChangeHeroStat(winner, STAT_MANA_POINTS, mana_to_restore)
        ShowFlyingSign({
            astral_spec_rmg.path.."mana_restored.txt"; amount = mana_to_restore
        }, winner, GetObjectOwner(winner), 6.0)
    end
end)