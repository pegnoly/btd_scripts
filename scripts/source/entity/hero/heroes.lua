while not MCCS_GENERATED_HEROES_TABLE do
  sleep()
end

Hero = 
{
    race_abilities = {13, 14, 15, 16, 17, 18, 151, 172},

    Params = 
    {
        Exception =
        function(hero, param)
            print("<color=red>Hero.Params.Exception: <color=green>hero - ", hero, ", param - ", param)
        end,
        
        Name =
        --- Определяет путь к файлу с именем героя
        ---@param hero string скриптовое имя героя
        ---@return string path путь к файлу
        function(hero)
            local ex = function(h) Hero.Params.Exception(h, "name") end
            errorHook(ex(hero))
            local answer = MCCS_GENERATED_HEROES_TABLE[hero].name
            return answer
        end,

        Class =
        --- Возвращает класс героя 
        ---@param hero string имя героя
        ---@return string class класс
        function(hero)
            errorHook(
            function()
                Hero.Params.Exception(%hero, "class")
            end)
            local answer = MCCS_GENERATED_HEROES_TABLE[hero].hero_class
            return answer
        end,

        Spec =
        --- Возвращает спецу героя 
        ---@param hero string имя героя
        ---@return string spec спеца
        function(hero)
            errorHook(
            function()
                Hero.Params.Exception(%hero, "spec")
            end)
            local answer = MCCS_GENERATED_HEROES_TABLE[hero].spec
            return answer
        end,

        Bio =
        --- Возвращает путь к файлу биографии героя 
        ---@param hero string имя героя
        ---@return string path путь
        function(hero)
            errorHook(
            function()
                Hero.Params.Exception(%hero, "bio")
            end)
            local answer = MCCS_GENERATED_HEROES_TABLE[hero].bio
            return answer
        end,

        Town =
        --- Возвращает город героя 
        ---@param hero string имя героя
        ---@return TownType town id города
        function(hero)
            errorHook(
            function()
                Hero.Params.Exception(%hero, "town")
            end)
            local answer = MCCS_GENERATED_HEROES_TABLE[hero].town
            return answer
        end,

        SpecName =
        --- Возвращает путь к файлу имени спецы героя 
        ---@param hero string имя героя
        ---@return string path путь
        function(hero)
            errorHook(
            function()
                Hero.Params.Exception(%hero, "spec_name")
            end)
            local answer = MCCS_GENERATED_HEROES_TABLE[hero].spec_name
            return answer
        end,

        SpecDesc =
        --- Возвращает путь к файлу описания спецы героя 
        ---@param hero string имя героя
        ---@return string path путь
        function(hero)
            errorHook(
            function()
                Hero.Params.Exception(%hero, "spec_desc")
            end)
            local answer = MCCS_GENERATED_HEROES_TABLE[hero].spec_desc
            return answer
        end,

        Icon =
        --- Возвращает путь к файлу иконки героя 
        ---@param hero string имя героя
        ---@return string path путь
        function(hero)
            errorHook(
            function()
                Hero.Params.Exception(%hero, "icon")
            end)
            local answer = MCCS_GENERATED_HEROES_TABLE[hero].icon.."#xpointer(/Texture)"
            return answer
        end,

        SpecIcon =
        --- Возвращает путь к файлу иконки спецы героя 
        ---@param hero string имя героя
        ---@return string path путь
        function(hero)
            errorHook(
            function()
                Hero.Params.Exception(%hero, "spec_icon")
            end)
            local answer = MCCS_GENERATED_HEROES_TABLE[hero].spec_icon.."#xpointer(/Texture)"
            return answer
        end
    },

    Stats = 
    {
        race_main_stat =
        {
            [TOWN_HEAVEN] = STAT_DEFENCE,
            [TOWN_PRESERVE] = STAT_DEFENCE,
            [TOWN_ACADEMY] = STAT_KNOWLEDGE,
            [TOWN_INFERNO] = STAT_ATTACK,
            [TOWN_NECROMANCY] = STAT_SPELL_POWER,
            [TOWN_DUNGEON] = STAT_SPELL_POWER,
            [TOWN_FORTRESS] = STAT_SPELL_POWER,
            [TOWN_STRONGHOLD] = STAT_ATTACK
        },

        Max =
        --- Определяет максимальный стат героя
        ---@param hero string имя героя
        ---@return HeroStatType stat тип стата
        function(hero)
            errorHook(
            function()
                Hero.Stats.Exception(%hero, "max_stat")
            end)
            local temp_stats = {}
            for stat = STAT_ATTACK, STAT_KNOWLEDGE do
                temp_stats[stat] = GetHeroStat(hero, stat)
            end
            local temp_max, temp_answer = -1000, 1
            for i = 1, 4 do
                if temp_stats[i] > temp_max then
                temp_max = temp_stats[i]
                temp_answer = i
                end
            end
            local answer, check_equal, n = temp_answer, {[1] = temp_answer}, 2
            for i = 1, 4 do
                if temp_stats[i] == temp_max and i ~= answer then
                check_equal[n] = i
                n = n + 1
                end
            end
            if length(check_equal) > 1 then
                answer = Random.FromTable(check_equal)
            end
            -- print('answer: ', answer)
            return answer
        end,

        Min =
        --- Определяет минимальный стат героя
        ---@param hero string имя героя
        ---@return HeroStatType stat тип стата
        function(hero)
            errorHook(
            function()
                Hero.Stats.Exception(%hero, "min_stat")
            end)
            local temp_stats = {}
            for stat = STAT_ATTACK, STAT_KNOWLEDGE do
                temp_stats[stat] = GetHeroStat(hero, stat)
            end
            local temp_min, temp_answer = math.huge, 1
            for i = 1, 4 do
                if temp_stats[i] < temp_min then
                temp_min = temp_stats[i]
                temp_answer = i
                end
            end
            local answer, check_equal, n = temp_answer, {[1] = temp_answer}, 2
            for i = 1, 4 do
                if temp_stats[i] == temp_min and i ~= answer then
                check_equal[n] = i
                n = n + 1
                end
            end
            if length(check_equal) > 1 then
                answer = Random.FromTable(check_equal)
            end
            -- print('answer: ', answer)
            return answer
        end,

        Change =
        --- Обертка над изменением статов
        ---@param hero string имя героя
        ---@param stat HeroStatType тип стата
        ---@param amount integer число стата
        function(hero, stat, amount)
            errorHook(
            function()
                Hero.Stats.Exception(%hero, "change_stat")
            end)
            local colors =
            {
                [1] = "/Text/Game/Player/Colors/green_color.txt",
                [2] = "/Text/Game/Player/Colors/red_color.txt"
            }
            local color = ''
            local sign = ''
            if amount < 0 then
                color = colors[2]
            elseif amount > 0 then
                color = colors[1]
                sign = rtext('+')
            else
                return
            end
            ChangeHeroStat(hero, stat, amount)
            if IsHeroAlive(hero) then
                MessageQueue.AddMessage(GetObjectOwner(hero), {'/Text/Default/change_stat.txt'; name = StatNames[stat], color = color, sign = sign, amount = amount}, hero, 5.0)
            end
        end
    },

    ArtInfo =
    {
        Exception =
        function(hero, ex)
            print("<color=red>Hero.ArtInfo.Exception: <color=green> hero - ", hero, " info - ", ex)
        end,

        AllArts =
        function(hero)
            errorHook(
            function()
                Hero.ArtInfo.Exception(%hero, "all arts")
            end)
            local answer, n = {}, 0
            for art = 1, ARTIFACTS_COUNT do
                if HasArtefact(hero, art) then
                for i = 1, GetHeroArtifactCount(hero, art) do
                    n = n + 1
                    answer[n] = art
                end
                end
            end
            return answer
        end,

        EquippedArts =
        function(hero)
            errorHook(
            function()
                Hero.ArtInfo.Exception(%hero, "equipped arts")
            end)
            local answer, n = {}, 0
            for art = 1, ARTIFACTS_COUNT do
                if HasArtefact(hero, art, 1) then
                n = n + 1
                answer[n] = art
                end
            end
            return answer
        end,

        EquippedArtsBySlot =
        function(hero, slot)
            errorHook(
            function()
                Hero.ArtInfo.Exception(%hero, "equipped arts by slot "..%slot)
            end)
            local answer, n = {}, 0
            for i, art in artsBySlot[slot] do
                if HasArtefact(hero, art, 1) then
                --print('art: ', art)
                n = n + 1
                answer[n] = art
                if slot ~= FINGER then
                    break
                end
                end
            end
            if n == 0 then
                return nil
            else
                return answer
            end
        end,

        EquippedArtsByClass =
        function(hero, type)
            errorHook(
            function()
                Hero.ArtInfo.Exception(%hero, "equipped arts by type "..%type)
            end)
            local answer, n = {}, 0
            for i, art in Hero.ArtInfo.EquippedArts(hero) do
                if Art.Params.Class(art) == type then
                n = n + 1
                answer[n] = art
                end
            end
            if n > 0 then
                return answer
            end
            return nil
        end,

        EquippedMinors =
        function(hero)
            errorHook(
            function()
                Hero.ArtInfo.Exception(%hero, "equipped minors")
            end)
            local answer, n = {}, 0
            for i, art in Hero.ArtInfo.EquippedArts(hero) do
                if Art.Params.Class(art) == ARTF_CLASS_MINOR then
                n = n + 1
                answer[n] = art
                end
            end
            if n > 0 then
                return answer
            end
            return nil
        end,

        EquippedMajors =
        function(hero)
            errorHook(
            function()
                Hero.ArtInfo.Exception(%hero, "equipped majors")
            end)
            local answer, n = {}, 0
            for i, art in Hero.ArtInfo.EquippedArts(hero) do
                if Art.Params.Class(art) == ARTF_CLASS_MAJOR then
                n = n + 1
                answer[n] = art
                end
            end
            if n > 0 then
                return answer
            end
            return nil
        end,

        EquippedRelics =
        function(hero)
        errorHook(
            function()
                Hero.ArtInfo.Exception(%hero, "equipped relics")
            end)
            local answer, n = {}, 0
            for i, art in Hero.ArtInfo.EquippedArts(hero) do
                if Art.Params.Class(art) == ARTF_CLASS_RELIC then
                n = n + 1
                answer[n] = art
                end
            end
            if n > 0 then
                return answer
            end
            return nil
        end
    },

    CreatureInfo =
    {
        Exception =
        function(hero, info)
            print("<color=red>Hero.CreatureInfo.Exception:<color=green> hero - ", hero, ", info - ", info)
        end,

        Replace =
        function (hero, town, targetUnitId, replaceId)
          errorHook(
          function()
              Hero.CreatureInfo.Exception(%hero, "Replacing creatures by town "..%town.." and id "..%targetUnitId.." on id "..%replaceId)
          end)

          local count = GetHeroCreatures(hero, targetUnitId);

          if count > 0 then
            RemoveHeroCreatures(hero, targetUnitId, count);
            AddHeroCreatures(hero, replaceId, count)
          end;
        end,

        GetByTier =
        --- Получает существ у героя по заданным городу и уровню
        ---@param hero string имя героя
        ---@param town TownType id города
        ---@param tier integer уровень существа
        ---@return table|nil creatures таблица существ
        function(hero, town, tier)
            errorHook(
            function()
                Hero.CreatureInfo.Exception(%hero, "Getting creatures by town "..%town.." and tier "..%tier)
            end)
            local tier_table = TIER_TABLES[town][tier]
            local answer = {}
            local n = 0
            for i, creature in tier_table do
                if GetHeroCreatures(hero, creature) > 0 then
                n = n + 1
                answer[n] = creature
                end
            end
            if n == 0 then
                return nil
            else
                return answer
            end
        end,

        Add =
        --- Добавляет герою существ, заданных парами id-число
        ---@param hero string имя героя
        ---@param ... CreatureID|integer id - число существ
        function(hero, ...)
            errorHook(
            function()
                local text = ""
                for i = 1, %arg.n, 2 do
                text = text.."["..%arg[i].."] = "..%arg[i + 1]..", "
                end
                Hero.CreatureInfo.Exception(%hero, "Adding creatures: "..text)
            end)
            for i = 1, arg.n, 2 do
                if arg[i + 1] < 0 then
                local curr_crt = GetObjectCreatures(hero, arg[i])
                local crt_removed = curr_crt >= math.abs(arg[i + 1]) and math.abs(arg[i + 1]) or curr_crt
                if crt_removed > 0 then
                    RemoveHeroCreatures(hero, arg[i], crt_removed)
                    MessageQueue.AddMessage(GetObjectOwner(hero), {'/Text/Default/remove_creature.txt'; name = Creature.Params.Name(arg[1]), num = crt_removed}, hero, 5.0)
                    sleep(12)
                end
                elseif arg[i + 1] ~= 0 then
                    AddHeroCreatures(hero, arg[i], arg[i + 1])
                    MessageQueue.AddMessage(GetObjectOwner(hero), {'/Text/Default/add_creature.txt'; name = Creature.Params.Name(arg[1]), num = arg[i + 1]}, hero, 5.0)
                    sleep(12)
                end
            end
        end,

        AddByTier =
        --- Добавляет герою существ, заданных тройками город - уровень - число
        ---@param hero string имя героя
        ---@param ... TownType|integer|integer город - уровень - число
        function(hero, ...)
            errorHook(
            function()
                local text = ""
                for i = 1, %arg.n, 3 do
                    text = text.."town - "..%arg[i].." : ["..%arg[i + 1].."] = "..%arg[i + 2]..", "
                end
                Hero.CreatureInfo.Exception(%hero, "Adding creatures by tiers: "..text)
            end)
            for i = 1, arg.n, 3 do
                local tier = Hero.CreatureInfo.GetByTier(hero, arg[i], arg[i + 1])
                if tier then
                    Hero.CreatureInfo.Add(hero, Random.FromTable(tier), arg[i + 2])
                else
                    Hero.CreatureInfo.Add(hero, Random.FromTable(TIER_TABLES[arg[i]][arg[i + 1]]), arg[i + 2])
                end
            end
        end,

        DefaultGrow =
        --- Осуществляет прирост существ для героя.
        ---@param hero string имя героя
        ---@param town TownType id города
        ---@param tier integer уровень существа
        ---@param amount integer число существ
        function(hero, town, tier, amount)
            errorHook(
            function()
                Hero.CreatureInfo.Exception(%hero, "Trying to give creatures by "..%town.." and tier "..%tier.." in amount of "..%amount)
            end)
            local creatures = Hero.CreatureInfo.GetByTier(hero, town, tier)
            local creature_to_add = -1
            if creatures then
                creature_to_add = Random.FromTable(creatures)
            else
                creature_to_add = TIER_TABLES[town][tier][1]
            end
            Hero.CreatureInfo.Add(hero, creature_to_add, amount)
        end,

        FullCount =
        --- Считает полное число существ у героя
        ---@param hero string имя героя
        ---@return integer num число существ
        function(hero)
            errorHook(
            function()
                Hero.CreatureInfo.Exception(%hero, "Calculating creatures full count")
            end)
            local object = GetHeroTown(hero) or hero
            local answer = 0
            for slot = 0, 6 do
                local creature, count = GetObjectArmySlotCreature(object, slot)
                if not (creature == 0 or count == 0) then
                    answer = answer + count
                end
            end
            return answer
        end,

        HasArmy =
        --- Определяет, есть ли у героя заданная армия
        ---@param hero string имя героя
        ---@param army table<CreatureID, integer> id существа - число существ
        ---@return boolean has имеется армия/нет
        function(hero, army)
        errorHook(
            function()
                Hero.CreatureInfo.Exception(%hero, "Checking for army - "..%army)
            end)
            local answer = 1
            for creature, count in army do
                if not (GetHeroCreatures(hero, creature) >= count) then
                    answer = nil
                    break
                end
            end
            return answer
        end,

        StackCount =
        --- Возвращает число стеков героя
        ---@param hero string имя героя
        ---@return integer count число стеков
        function(hero)
            errorHook(
            function()
                Hero.CreatureInfo.Exception(%hero, "checking stack count")
            end)
            local answer = 0
            local stacks = table.pack(GetHeroCreaturesTypes(hero))
            for i, type in stacks do
                if type ~= 0 then
                    answer = answer + 1
                else
                    break
                end
            end
            return answer
        end,
    },
    SpellInfo =
    {
        Exception =
        function(hero, spell_info)
            print("<color=red>Hero.SpellInfo_info.Exception:<color=green> hero - ", hero, ", spell_info - ", spell_info)
        end,

        GetKnownSpellsBySchool =
        --- Возвращает известные герою спеллы в школе
        ---@param hero string имя героя
        ---@param school SpellSchoolType школа
        ---@return integer[] spells список спеллов
        function(hero, school)
            errorHook(
            function()
                Hero.SpellInfo.Exception(%hero, "Getting known spells by school "..%school)
            end)
            local answer, n = {}, 0
            for i, spell in spellsBySchools[school] do
                if KnowHeroSpell(hero, spell) then
                    n = n + 1
                    answer[n] = spell
                end
            end
            return answer
        end,

        TeachSpell =
        --- Обертка для изучения спеллов
        ---@param hero string имя героя
        ---@param spell integer id спелла
        function(hero, spell)
            errorHook(
            function()
                Hero.SpellInfo.Exception(%hero, "Teaching "..%spell)
            end)
            MakeHeroInteractWithObject(hero, "SHRINE_"..spell)
            if IsHeroAlive(hero) then
                MessageQueue.AddMessage(GetObjectOwner(hero), {'/Text/Default/spell_learned.txt'; name = Spell.Params.Name(spell)}, hero, 6.0)
            end
        end,

        Learnable = 
        {
            Decorator =
            {
                [MASTERY_NONE] = function(mastery, p) return 1 end,
                [MASTERY_BASIC] = function(mastery, p) local answer = (p[1] + p[2]) >= mastery return answer end,
                [MASTERY_ADVANCED] = function(mastery, p) local answer = (p[1] + p[2] + p[3]) >= mastery return answer end,
                [MASTERY_EXPERT] = function(mastery, p) local answer = p[1] >= mastery return answer end,
                [MASTERY_EXTRA_EXPERT] = function(mastery, p) local answer = p[1] >= mastery return answer end,
            },
            RunesLevels =
            {
                [1] = {1},
                [2] = {1, 2, 3},
                [3] = {1, 2, 3, 4, 5},
                [4] = {1, 2, 3, 4, 5}
            },
            WarcriesLevels =
            {
                [SPELL_WARCRY_RALLING_CRY] = 1,
                [SPELL_WARCRY_CALL_OF_BLOOD] = 1,
                [SPELL_WARCRY_WORD_OF_THE_CHIEF] = 6,
                [SPELL_WARCRY_FEAR_MY_ROAR] = 6,
                [SPELL_WARCRY_BATTLECRY] = 11,
                [SPELL_WARCRY_SHOUT_OF_MANY] = 11
            },
        },

        GetLearnableSpells =
        --- Возвращает доступные герою для изучения спеллы в школе
        ---@param hero string имя героя
        ---@param school SpellSchoolType школа
        ---@return integer[] spells таблица спеллов
        function(hero, school)
        errorHook(
            function()
                Hero.SpellInfo.Exception(%hero, "getting learnable spells by "..%school)
            end)
            local school_mastery = -1
            local wisdom_flag = HasHeroSkill(hero, SKILL_WISDOM) and 1 or 0
            local tome_flag = HasArtefact(hero, ARTIFACT_BOOK_OF_POWER, 1) and 1 or 0
            school_mastery = GetHeroSkillMastery(hero, skillsBySchools[school])
            local answer, n = {}, 0
            for _, spell in spellsBySchools[school] do
                if not KnowHeroSpell(hero, spell) and 
                    Hero.SpellInfo.Learnable.Decorator(Spell.Params.Mastery(spell), {school_mastery, wisdom_flag, tome_flag}) then
                    n = n + 1
                    answer[n] = spell
                end
            end
            return answer
        end,

        GetLearnableRunes =
        --- Возвращает доступные герою для изучения руны
        ---@param hero string имя героя
        ---@return integer[] runes таблица рун
        function(hero)
        errorHook(
            function()
                Hero.SpellInfo.Exception(%hero, "getting learnable runes")
            end)
            local runelore_mastery = GetHeroSkillMastery(hero, HERO_SKILL_RUNELORE)
            local answer, n = {}, 0
            for _, rune in spellsBySchools[MAGIC_SCHOOL_RUNIC] do
                if not KnowHeroSpell(rune) and (contains(Hero.SpellInfo.Learnable.RuneLevels[runelore_mastery], Spell.Params.Level(rune))) then
                n = n + 1
                end
            end
            return answer
        end,

        GetLearnableWarcries =
        --- Возвращает доступные герою для изучения кличи
        ---@param hero string имя героя
        ---@return integer[] warcries таблица кличей
        function(hero)
            errorHook(
            function()
                Hero.SpellInfo.Exception(%hero, "getting learnable warcries")
            end)
            local level = GetHeroLevel(hero)
            local answer, n = {}, 0
            for _, warcry in spellsBySchools[MAGIC_SCHOOL_WARCRIES] do
                if not KnowHeroSpell(warcry) and (level >= Hero.SpellInfo.Learnable.WarcriesLevels[warcry]) then
                    n = n + 1
                    answer[n] = warcry
                end
            end
            return answer
        end,
        
        GetLearnableSpellsByLevel =
        function(hero, level, with_wisdom)
            with_wisdom = with_wisdom or nil
            local spells, n = {}, 0
            local has_wisdom = HasHeroSkill(hero, PERK_WISDOM)
            for i, school in {MAGIC_SCHOOL_DESTRUCTIVE, MAGIC_SCHOOL_DARK, MAGIC_SCHOOL_LIGHT, MAGIC_SCHOOL_SUMMONING} do
                for j, spell in spellsBySchools[school] do
                    if (Spell.Params.Level(spell) == level) and (not KnowHeroSpell(hero, spell)) then
                        local spell_mastery = Spell.Params.Mastery(spell)
                        local hero_mastery = GetHeroSkillMastery(hero, skillsBySchools[school])
                        --
                        if with_wisdom and level == 3 and has_wisdom == 1 then
                            hero_mastery = hero_mastery + 1
                        end
                        --
                        if hero_mastery >= spell_mastery then
                            n = n + 1
                            spells[n] = spell
                        end
                    end
                end
            end
            if n ~= 0 then
                return spells
            else
                return nil
            end
        end
    },

    Threads =
    {
        Exception =
        function(hero, thread_info)
            print("<color=red>Hero.Threads.Exception: <color=green>hero - ", hero, ", thread info - ", thread_info)
        end,

        StatUpdater =
        function(hero)
            errorHook(
            function()
                Hero.Threads.Exception(%hero, "stats updater")
            end)
            local stats =
            {
                [STAT_ATTACK] = {name = '_Attack', val = -1000},
                [STAT_DEFENCE] = {name = '_Defence', val = -1000},
                [STAT_SPELL_POWER] = {name = '_Spellpower', val = -1000},
                [STAT_KNOWLEDGE] = {name = '_Knowledge', val = -1000},
                [STAT_MORALE] = {name = '_Morale', val = -1000},
                [STAT_LUCK] = {name = '_Luck', val = -1000},
            }
            --
            while 1 do
                if IsHeroAlive(hero) then
                    for stat, info in stats do
                        local curr_val = GetHeroStat(hero, stat)
                        if curr_val ~= info.val then
                            stats[stat].val = curr_val
                            consoleCmd("@SetGameVar('"..hero..""..info.name.."', '"..curr_val.."')")
                        end
                    end
                end
                sleep()
            end
        end,

        LevelUp =
        function(hero)
            errorHook(
            function()
                Hero.Threads.Exception(%hero, "level up")
            end)
            --
            while not LevelUpEvent do
                sleep()
            end
            --
            local curr_lvl = GetHeroLevel(hero)
            consoleCmd("@SetGameVar('"..hero.."_lvl', "..curr_lvl..")")
            while 1 do
                while GetHeroLevel(hero) == curr_lvl do
                    sleep()
                end
                curr_lvl = GetHeroLevel(hero)
                consoleCmd("@SetGameVar('"..hero.."_lvl', "..curr_lvl..")")
                startThread(LevelUpEvent.Invoke, hero)
                --
                sleep()
            end
        end,

        XpTracker =
        function(hero)
            errorHook(
            function()
                Hero.Threads.Exception(%hero, "xp tracker")
            end)
            --
            while not XpTrackingEvent do
                sleep()
            end
            --
            local curr_exp, new_exp = GetHeroStat(hero, STAT_EXPERIENCE), 0
            while 1 do
                new_exp = GetHeroStat(hero, STAT_EXPERIENCE)
                if new_exp ~= curr_exp then
                    if new_exp > curr_exp then
                        startThread(XpTrackingEvent.Invoke, hero, curr_exp, new_exp)
                            --
                    end
                    curr_exp = new_exp
                end
                sleep()
            end
        end,

        UnlimMove =
        --- Дает бесконечное пермещение герою
        ---@param hero string имя героя
        ---@param cond function условие бесконечного перемещения
        function(hero, cond)
            errorHook(
            function()
                Hero.Threads.Exception(%hero, "unlim move")
            end)
            while cond() do
                ChangeHeroStat(hero, STAT_MOVE_POINTS, 10000)
                sleep()
            end
        end
    }
}