while not MCCS_ARTIFACTS_GENERATED_TABLE do
    sleep()
end

Art = 
{
    --- *КОНСТАНТЫ* ---
    Params = 
    {
        Exception =
        function(art, ex)
            print("<color=red>Art.Params.Exception: <color=green> art - ", art, ", param - ", ex)
        end,

        Class =
        --- Возвращает класс артефакта
        ---@param art ArtifactID id артефакта
        ---@return ArtifactClass class класс артефакта
        function(art)
            errorHook(
            function()
                Art.Params.Exception(%art, "class")
            end)
            local answer = MCCS_ARTIFACTS_GENERATED_TABLE[art].type
            return answer
        end,

        Name =
        --- Возвращает путь к имени артефакта
        ---@param art ArtifactID id артефакта
        ---@return string path путь к имени
        function(art)
            errorHook(
            function()
                Art.Params.Exception(%art, "name")
            end)
            local answer = MCCS_ARTIFACTS_GENERATED_TABLE[art].name
            return answer
        end,

        Icon =
        --- Возвращает путь к иконке артефакта
        ---@param art ArtifactID id артефакта
        ---@return string path путь к иконке
        function(art)
            errorHook(
            function()
                Art.Params.Exception(%art, "icon")
            end)
            local answer = MCCS_ARTIFACTS_GENERATED_TABLE[art].icon.."#xpointer(/Texture)"
            return answer
        end,

        Slot =
        --- Возвращает слот артефакта
        ---@param art ArtifactID id артефакта
        ---@return ArtifactSlot slot слот артефакта
        function(art)
            errorHook(
            function()
                Art.Params.Exception(%art, "slot")
            end)
            local answer = MCCS_ARTIFACTS_GENERATED_TABLE[art].slot
            return answer
        end,

        Cost =
        --- Возвращает цену артефакта
        ---@param art ArtifactID id артефакта
        ---@return number cost цена артефакта
        function(art)
            errorHook(
            function()
                ArtParams.Exception(%art, "cost")
            end)
            local answer = MCCS_ARTIFACTS_GENERATED_TABLE[art].cost
            return answer
        end,

        IsSellable =
        --- Определяет, генерируется ли артефакт на карте и в лавках
        ---@param art ArtifactID id артефакта
        ---@return boolean sellable генерируемость артефакта
        function(art)
            errorHook(
            function()
                Art.Params.Exception(%art, "is_sellable")
            end)
            local answer = MCCS_ARTIFACTS_GENERATED_TABLE[art].is_sellable
            return answer
        end
    },

    Distribution =
    {
        Exception =
        function(ex)
            print("<color=red>Art.Distribution.Exception: <color=green>", ex)
        end,

        Init =
        ---@meta
        function()
            errorHook(
            function()
                Art.Distribution.Exception("Init")
            end)
            local minor_count, major_count, relic_count = 0, 0, 0
            for art, info in MCCS_ARTIFACTS_GENERATED_TABLE do
                if info.slot ~= INVENTORY and info.is_sellable then
                    if info.type == ARTF_CLASS_MINOR then
                        minor_count = minor_count + 1
                        artsByClass[ARTF_CLASS_MINOR][minor_count] = art
                    elseif info.type == ARTF_CLASS_MAJOR then
                        major_count = major_count + 1
                        artsByClass[ARTF_CLASS_MAJOR][major_count] = art
                    elseif info.type == ARTF_CLASS_RELIC then
                        relic_count = relic_count + 1
                        artsByClass[ARTF_CLASS_RELIC][relic_count] = art
                    end
                end
            end
            --
            for slot_type = PRIMARY, INVENTORY do
                for art, info in MCCS_ARTIFACTS_GENERATED_TABLE do
                    if info.slot == slot_type then
                        artsBySlot[slot_type][len(artsBySlot[slot_type]) + 1] = art
                    end
                end
            end
        end,

        RandomMinor =
        --- Возвращает случайный артефакт класса минор
        ---@return ArtifactID art_id id артефакта
        function()
            errorHook(
            function()
                Art.Distribution.Exception("random minor")
            end)
            local answer = Random.FromTable(artsByClass[ARTF_CLASS_MINOR])
            return answer
        end,

        RandomMajor =
        --- Возвращает случайный артефакт класса мажор
        ---@return ArtifactID art_id id артефакта
        function()
            errorHook(
            function()
                Art.Distribution.Exception("random major")
            end)
            local answer = Random.FromTable(artsByClass[ARTF_CLASS_MAJOR])
            return answer
        end,

        RandomRelic =
        --- Возвращает случайный артефакт класса релик
        ---@return ArtifactID art_id id артефакта
        function()
            errorHook(
            function()
                Art.Distribution.Exception("random relic")
            end)
            local answer = Random.FromTable(artsByClass[ARTF_CLASS_RELIC])
            return answer
        end,

        RandomArtOfClass =
        --- Возвращает случайный артефакт заданного класса
        ---@param class ArtifactClass класс артефакта
        ---@return ArtifactID art_id id артефакта
        function(class)
            errorHook(
            function()
                Art.Distribution.Exception("random art of class "..%class)
            end)
            local answer = -1
            if class == ARTF_CLASS_MINOR then
                answer = Art.Distribution.RandomMinor()
            elseif class == ARTF_CLASS_MAJOR then
                answer = Art.Distribution.RandomMajor()
            elseif class == ARTF_CLASS_RELIC then
                answer = Art.Distribution.RandomRelic()
            end
            return answer
        end,

        Give =
        --- Обертка выдачи артефакта герою
        ---@param hero string имя героя
        ---@param art number id артефакта
        ---@param bind_to_hero boolean привязывать к герою или нет
        function(hero, art, bind_to_hero)
            errorHook(
            function()
                Art.Distribution.Exception("give")
            end)
            bind_to_hero = bind_to_hero or 0
            GiveArtifact(hero, art, bind_to_hero)
            MessageQueue.AddMessage(GetObjectOwner(hero), {'/Text/Default/give_artifact.txt'; name = Art.Params.Name(art)}, hero, 6.0)
        end
    },

    Generation =
    {
        Exception =
        function(ex)
            print("<color=red>Art.Generation.Exception: <color=green>", ex)
        end,

        BySlotTierAndCost =
        --- Возвращает подборку артефактов по заданным параметрам
        ---@param slot ArtifactSlot слот артефакта
        ---@param class ArtifactClass класс артефакта
        ---@param cost number цена артефакта
        ---@param except_arts ArtifactID[] игнорируемые артефакты
        ---@return ArtifactID[] arts список подходящих артефактов
        function(slot, class, cost, except_arts)
            errorHook(
            function()
                Art.Generation.Exception("generating table of arts of slot "..%slot..", class "..%class.." and cost "..%cost.." with exceptions "..%except_arts)
            end)
            local tbl, answer, n = {}, {}, 0
            if class == ARTF_CLASS_MINOR then
                tbl = artsByClass[ARTF_CLASS_MINOR]
            elseif class == ARTF_CLASS_MAJOR then
                tbl = artsByClass[ARTF_CLASS_MAJOR]
            elseif class == ARTF_CLASS_RELIC then
                tbl = artsByClass[ARTF_CLASS_RELIC]
            end
            for i, art in tbl do
                if (not contains(except_arts, art)) and
                    Art.Params.Slot(art) == slot and
                    Art.Params.Cost(art) <= cost then
                n = n + 1
                answer[n] = i
                end
            end
            if n > 0 then
                return answer
            else
                return nil
            end
        end,

        CreateSet =
        --- Генерирует сет артефактов по заданным параметрам
        ---@param all_count integer общее число артефактов
        ---@param max_relics integer число реликов
        ---@param max_majors integer число мажоров
        ---@param preset string пресет артефактов
        ---@param preset_proc_chance number шанс прока пресет при генерации отдельных артефактов
        ---@return ArtifactID[] arts список артефактов
        function(all_count, max_relics, max_majors, preset, preset_proc_chance)
            errorHook(
            function()
                Art.Generation.Exception("generating art set of "..%all_count..", arts, "..%max_relics.." relics and "..%max_majors.." majors, with preset "..%preset.." and its proc chance "..%preset_proc_chance)
            end)
            local answer, n = {}, 0
            if all_count > 10 then
                all_count = 10
            end
            local counts = {max_relics, max_majors, (all_count - max_relics - max_majors)}
            local check_array, ring_check = {}, 1
            for tier = ARTF_CLASS_MINOR, ARTF_CLASS_RELIC do
                for j = 1, counts[tier] do
                local tbl
                if preset and (random(100) + 1) < preset_proc_chance then
                    tbl = preset[tier]
                else
                    tbl = Art.by_type[tier]
                end
                local art, slot
                repeat
                    art = Random.FromTable(tbl)
                    slot = Art.Params.Slot(art)
                until ((not check_array[slot]) and (not contains(answer, art)) and (slot ~= INVENTORY))
                check_array[slot] = 1
                --
                if slot == FINGER and ring_check then
                    ring_check = nil
                    check_array[slot] = nil
                end
                --
                n = n + 1
                answer[n] = art
                end
            end
            --
            local msg = 'ArtGeneration.CreateSet: '
            for i, art in answer do
                msg = msg..Art.Params.Name(art)..' '
            end
            print(msg)
            --
            return answer
        end
    }
}