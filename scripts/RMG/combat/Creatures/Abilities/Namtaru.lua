-- }{0TT@6b)4. 11.02.2023
-- Нуждается в доработке
Namtaru = {

IDs={[900]=1,},

cast_list = { --Better to add control of different spells types - area, target and global,
              --but i have no time to release it
[1] = {id=212},
},

startCast=function()
  for side=0,1 do
    for n, unit in GetCreatures(side) do
      if Namtaru.IDs[GetCreatureType(unit)] then
        local mana = GetUnitManaPoints(unit)
        SetUnitManaPoints(unit, 200)
        while GetUnitManaPoints(unit)~=200 do sleep() end
        for n, spell in Namtaru.cast_list do
          UnitCastGlobalSpell(unit, spell.id)
        end
        SetUnitManaPoints(unit, mana)
      end
    end
  end
end,

}

while not CombatFunctions do sleep() end;
AddCombatFunction(CombatFunctions.START, "namtaru_start_cast", Namtaru.startCast)