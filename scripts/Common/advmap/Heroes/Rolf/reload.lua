consoleCmd("@CombatConnection.combat_scripts_paths['Rolf_spec'] = '/scripts/Common/combat/Heroes/Rolf/script.lua'")

function RolfTest()
    local creatures = {204, 205}
    for i, cr in creatures do
        AddHeroCreatures("Rolf", cr, 1)
    end
end