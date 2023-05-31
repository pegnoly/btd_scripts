Generation = 
{
    BySpec =
    {
        [HERO_SPEC_RADIANT] = 
        function(hero)
            AddHeroCreatures(hero, CREATURE_GENIE, 1)
        end,

        [HERO_SPEC_MATRON_SALVO] = 
        function(hero)
            AddHeroCreatures(hero, CREATURE_MATRON, 1)
        end,

        [HERO_SPEC_RIDERS] = 
        function(hero)
            AddHeroCreatures(hero, CREATURE_RIDER, 1)
        end,
        
        [HERO_SPEC_WYVERN_TAMER] =
        function(hero)
            AddHeroCreatures(hero, CREATURE_WYVERN, 1)
        end,

        [HERO_SPEC_MASTER_OF_ELEMENTS] = 
        function(hero)
            AddHeroCreatures(hero, Random.FromSelection(CREATURE_AIR_ELEMENTAL, CREATURE_EARTH_ELEMENTAL, CREATURE_WATER_ELEMENTAL, CREATURE_FIRE_ELEMENTAL), random(2) + 1)
        end,

        [HERO_SPEC_SOULHUNTER] = 
        function(hero)
            RemoveHeroCreatures(hero, CREATURE_WALKING_DEAD, 9999)
            AddHeroCreatures(hero, CREATURE_MANES, 7 + random(2))
        end,
        
        [HERO_SPEC_GRIFFINS] =
        function(hero)
            AddHeroCreatures(hero, CREATURE_GRIFFIN, random(2) + 1)
        end,

        [HERO_SPEC_PEASANTS] =
        function(hero)
            for slot = 0, 6 do
                local creature, count = GetObjectArmySlotCreature(hero, slot)
                if not (creature == 0 or count == 0) then
                    if creature == CREATURE_PEASANT then
                        RemoveHeroCreatures(hero, creature, count, slot)
                        AddHeroCreatures(hero, CREATURE_ARCHER, 6 + random(3))
                        break
                    end
                end
            end
        end,

        [HERO_SPEC_FOOTMEN] = 
        function(hero)
            for slot = 0, 6 do
                local creature, count = GetObjectArmySlotCreature(hero, slot)
                if not (creature == 0 or count == 0) then
                    if creature == CREATURE_FOOTMAN then
                        RemoveHeroCreatures(hero, creature, count, slot)
                        AddHeroCreatures(hero, CREATURE_ARCHER, 6 + random(3))
                        break
                    end
                end
            end
        end,

        [HERO_SPEC_BEAR_RIDERS] = 
        function(hero)
            for slot = 0, 6 do
                local creature, count = GetObjectArmySlotCreature(hero, slot)
                if not (creature == 0 or count == 0) then
                    if creature == CREATURE_BEAR_RIDER then
                        RemoveHeroCreatures(hero, creature, count, slot)
                        AddHeroCreatures(hero, CREATURE_AXE_FIGHTER, 7 + random(4))
                        break
                    end
                end
            end
        end,

        [HERO_SPEC_DEFENDER] = 
        function(hero)
            for slot = 0, 6 do
                local creature, count = GetObjectArmySlotCreature(hero, slot)
                if not (creature == 0 or count == 0) then
                    if creature == CREATURE_DEFENDER then
                        RemoveHeroCreatures(hero, creature, count, slot)
                        AddHeroCreatures(hero, CREATURE_BEAR_RIDER, 2 + random(2))
                        break
                    end
                end
            end
        end,

        [HERO_SPEC_VAMPIRES] =
        function(hero)
            AddHeroCreatures(hero, CREATURE_VAMPIRE, 1)
        end,

        [HERO_SPEC_GRIM_FIGHTER] = 
        function(hero)
            for slot = 0, 6 do
                local creature, count = GetObjectArmySlotCreature(hero, slot)
                if not (creature == 0 or count == 0) then
                    if creature == CREATURE_ORC_WARRIOR then
                        RemoveHeroCreatures(hero, creature, count, slot)
                        AddHeroCreatures(hero, CREATURE_CENTAUR, 6 + random(3))
                        break
                    end
                end
            end
        end,

        [HERO_SPEC_GOLEMS] = 
        function(hero)
            for slot = 0, 6 do
                local creature, count = GetObjectArmySlotCreature(hero, slot)
                if not (creature == 0 or count == 0) then
                    if creature == CREATURE_IRON_GOLEM then
                        RemoveHeroCreatures(hero, creature, count, slot)
                        AddHeroCreatures(hero, CREATURE_GREMLIN, 22 + random(5))
                        break
                    end
                end
            end
        end,

        [HERO_SPEC_MAGES] = 
        function(hero)
            AddHeroCreatures(hero, CREATURE_MAGI, 1)
        end,

        [HERO_SPEC_SUCCUBUSES] = 
        function(hero)
            AddHeroCreatures(hero, CREATURE_SUCCUBUS, 1)
        end,

        [HERO_SPEC_HOUNDS] = 
        function(hero)
            for slot = 0, 6 do
                local creature, count = GetObjectArmySlotCreature(hero, slot)
                if not (creature == 0 or count == 0) then
                    if creature == CREATURE_HELL_HOUND then
                        RemoveHeroCreatures(hero, creature, count, slot)
                        AddHeroCreatures(hero, CREATURE_FAMILIAR, 16 + random(7))
                        break
                    end
                end
            end
        end,

        [HERO_SPEC_BLADE_MASTER] = 
        function(hero)
            for slot = 0, 6 do
                local creature, count = GetObjectArmySlotCreature(hero, slot)
                if not (creature == 0 or count == 0) then
                    if creature == CREATURE_BLADE_JUGGLER then
                        RemoveHeroCreatures(hero, creature, count, slot)
                        AddHeroCreatures(hero, CREATURE_PIXIE, 10 + random(4))
                        break
                    end
                end
            end
        end
    },
    
    ByHero =
    {
        ["Wulfstan"] =
        function(hero)
            AddHeroCreatures(hero, CREATURE_BROWLER, 3)
        end,
        
        ["Kujin"] =
        function(hero)
            AddHeroCreatures(hero, CREATURE_SHAMAN, 2)
        end,
    },

    Init =
    function()
        AddHeroEvent.AddListener("BTD_RMG_army_generation_add_hero",
        function(hero)
            local hero_spec = Hero.Params.Spec(hero)
            for spec, func in Generation.BySpec do
                if spec == hero_spec then
                    startThread(Generation.BySpec[spec], hero)
                    break
                end
            end
            --
            for _hero, func in Generation.ByHero do
                if hero == _hero then
                    startThread(Generation.ByHero[_hero], hero)
                end
            end
        end)
    end
}

startThread(Generation.Init)