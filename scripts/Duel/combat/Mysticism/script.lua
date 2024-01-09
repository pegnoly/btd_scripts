mysticism_duel = 
{
    [ATTACKER] = {
        max_mana = -1,
        used = nil
    },
    [DEFENDER] = {
        max_mana = -1,
        used = nil
    },
    path = "/scripts/Duel/combat/Mysticism/",
    mana_bottom_percent = 0.1,
    mana_restore_base = 10,
    mana_restore_percent = 0.15
}

if GetGameVar(GetHeroName(GetAttackerHero()).."_MYSTICISM") == 'active' then
    mysticism_duel[ATTACKER].max_mana = GetUnitMaxManaPoints(GetAttackerHero())
    AddCombatFunction(CombatFunctions.START, "mysticism_duel_start_attacker",
    function()
        startThread(MysticismDuel_ManaCheckThread, GetAttackerHero(), ATTACKER)
    end)
end
  
if GetDefenderHero() and (GetGameVar(GetHeroName(GetDefenderHero()).."_MYSTICISM") == 'active') then
    mysticism_duel[DEFENDER].max_mana = GetUnitMaxManaPoints(GetDefenderHero())
    AddCombatFunction(CombatFunctions.START, "mysticism_duel_start_defender",
    function()
        startThread(MysticismDuel_ManaCheckThread, GetDefenderHero(), DEFENDER)
    end)
end

function MysticismDuel_ManaCheckThread(hero, side)
    while 1 do
        local current_mana = GetUnitManaPoints(hero)
        if current_mana / mysticism_duel[side].max_mana <= mysticism_duel.mana_bottom_percent then
            local mana_to_restore = ceil(mysticism_duel[side].max_mana * mysticism_duel.mana_restore_percent + mysticism_duel.mana_restore_base)
            startThread(CombatFlyingSign, {
                mysticism_duel.path.."mana_restored.txt"; amount = mana_to_restore
            }, hero, 7.0)
            startThread(playAnimation, hero, "cast", ONESHOT)
            SetUnitManaPoints(hero, current_mana + mana_to_restore)
            return
        end
        sleep()
    end
end