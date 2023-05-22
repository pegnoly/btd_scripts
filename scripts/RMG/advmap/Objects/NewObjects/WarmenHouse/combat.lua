warmen_house =
{
    [ATTACKER] = {},
    [DEFENDER] = {}
}

if GetGameVar(GetHeroName(GetAttackerHero()).."_warmen_house_bonus") == "active" then
    AddCombatFunction(CombatFunctions.START, "BTD_warmen_house_start_attacker",
    function()
        startThread(WarmenHouse_Start, ATTACKER)
    end)
end

if GetDefenderHero() and  GetGameVar(GetHeroName(GetDefenderHero()).."_warmen_house_bonus") == "active" then
    AddCombatFunction(CombatFunctions.START, "BTD_warmen_house_start_defender",
    function()
        startThread(WarmenHouse_Start, DEFENDER)
    end)
end

function WarmenHouse_Start(side)
    local helper = "warmen_house_helper_"..side
    if pcall(AddCreature, side, 979, 10, -1, -1, nil, helper) then
        while not exist(helper) do
            sleep()
        end
        pcall(UnitCastGlobalSpell, helper, SPELL_WARCRY_RALLING_CRY)
        sleep()
        removeUnit(helper)
    end
end