while not MCCS_SPELL_GENERATED_TABLE do
  sleep()
end

Spell =
{
    Params =
    {
        Exception =
        function(spell, ex)
            print("<color=red>Spell.Params.Exception: <color=green>spell - ", spell, ", param - ", ex)
        end,

        Name =
        --- Возвращает путь к файлу имени спелла
        ---@param spell integer id спелла
        ---@return string path путь
        function(spell)
            errorHook(
            function()
                Spell.Params.Exception(%spell, "name")
            end)
            local answer = MCCS_SPELL_GENERATED_TABLE[spell].name
            return answer
        end,

        Level =
        --- Возвращает уровень спелла
        ---@param spell integer id спелла
        ---@return integer level уровень
        function(spell)
            errorHook(
            function()
                Spell.Params.Exception(%spell, "level")
            end)
            local answer = MCCS_SPELL_GENERATED_TABLE[spell].level
            return answer  
        end,

        Mastery =
        --- Возвращает уровень мастерства, необходимый для изучения спелла
        ---@param spell integer id спелла
        ---@return MasteryLevel mastery уровень мастерства
        function(spell)
            errorHook(
            function()
                Spell.Params.Exception(%spell, "mastery")
            end)
            local level = MCCS_SPELL_GENERATED_TABLE[spell].level
            local answer = (level >= 3) and (level - 2) or MASTERY_NONE
            return answer
        end,

        Type =
        --- Возвращает тип каста спелла
        ---@param spell integer id спелла
        ---@return SpellCastType type тип каста
        function(spell)
            errorHook(
            function()
                Spell.Params.Exception(%spell, "type")
            end)
            local answer = MCCS_SPELL_GENERATED_TABLE[spell].type
            return answer
        end,
        
        School =
        function(spell)
            errorHook(
            function()
                Spell.Params.Exception(%spell, "school")
            end)
            local answer = MCCS_SPELL_GENERATED_TABLE[spell].school
            return answer
        end,
    }
}