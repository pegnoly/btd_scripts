--- 25.05.2023 - combined DarkRitual perk and Almegir's spec here.

dark_ritual = 
{
    [ATTACKER] = {},
    [DEFENDER] = {},

    mana_to_add = 40,

    specialists = {"Almegir", "Almegir1", "Almegir2"}
}

if GetGameVar(GetHeroName(GetAttackerHero()).."_DARK_RITUAL") == '1' then
    AddCombatFunction(CombatFunctions.START, "dark_ritual_start_attacker",
    function()
        DarkRitual_Start(ATTACKER)
    end)
end
  
if GetDefenderHero() and (GetGameVar(GetHeroName(GetDefenderHero()).."_DARK_RITUAL") == '1') then
    AddCombatFunction(CombatFunctions.START, "dark_ritual_start_defender",
    function()
        DarkRitual_Start(DEFENDER)
    end)
end

function DarkRitual_Start(side)
    local hero = GetHero(side)
    local mult = contains(dark_ritual.specialists, GetHeroName(hero)) and 2 or 1
    local mana_to_set = GetUnitManaPoints(hero) + (dark_ritual.mana_to_add * mult)
    SetUnitManaPoints(hero, mana_to_set)
end