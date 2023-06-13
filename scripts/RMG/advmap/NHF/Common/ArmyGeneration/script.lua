Generation = 
{
    BySpec =
    {
        [HERO_SPEC_RADIANT] = 
        function(object)
            AddObjectCreatures(object, CREATURE_GENIE, 1)
        end,

        [HERO_SPEC_MATRON_SALVO] = 
        function(object)
            AddObjectCreatures(object, CREATURE_MATRON, 1)
        end,

        [HERO_SPEC_RIDERS] = 
        function(object)
            AddObjectCreatures(object, CREATURE_RIDER, 1)
        end,
        
        [HERO_SPEC_WYVERN_TAMER] =
        function(object)
            AddObjectCreatures(object, CREATURE_WYVERN, 1)
        end,

        [HERO_SPEC_MASTER_OF_ELEMENTS] = 
        function(object)
            AddObjectCreatures(object, Random.FromSelection(CREATURE_AIR_ELEMENTAL, CREATURE_EARTH_ELEMENTAL, CREATURE_WATER_ELEMENTAL, CREATURE_FIRE_ELEMENTAL), random(2) + 1)
        end,

        [HERO_SPEC_SOULHUNTER] = 
        function(object)
            RemoveObjectCreatures(object, CREATURE_WALKING_DEAD, 9999)
            AddObjectCreatures(object, CREATURE_MANES, 7 + random(2))
        end,
        
        [HERO_SPEC_GRIFFINS] =
        function(object)
            AddObjectCreatures(object, CREATURE_GRIFFIN, random(2) + 1)
        end,

        [HERO_SPEC_PEASANTS] =
        function(object)
            AddObjectCreatures(object, CREATURE_ARCHER, 6 + random(3))
        end,

        [HERO_SPEC_FOOTMEN] = 
        function(object)
            AddObjectCreatures(object, CREATURE_ARCHER, 6 + random(3))
        end,

        [HERO_SPEC_BEAR_RIDERS] = 
        function(object)
            AddObjectCreatures(object, CREATURE_AXE_FIGHTER, 7 + random(4))
        end,

        [HERO_SPEC_DEFENDER] = 
        function(object)
            AddObjectCreatures(object, CREATURE_BEAR_RIDER, 2 + random(2))
        end,

        [HERO_SPEC_VAMPIRES] =
        function(object)
            AddObjectCreatures(object, CREATURE_VAMPIRE, 1)
        end,

        [HERO_SPEC_GRIM_FIGHTER] = 
        function(object)
            AddObjectCreatures(object, CREATURE_CENTAUR, 6 + random(3))
        end,

        [HERO_SPEC_GOLEMS] = 
        function(object)
            AddObjectCreatures(object, CREATURE_GREMLIN, 22 + random(5))
        end,

        [HERO_SPEC_MAGES] = 
        function(object)
            AddObjectCreatures(object, CREATURE_MAGI, 1)
        end,

        [HERO_SPEC_SUCCUBUSES] = 
        function(object)
            AddObjectCreatures(object, CREATURE_SUCCUBUS, 1)
        end,

        [HERO_SPEC_HOUNDS] = 
        function(object)
            AddObjectCreatures(object, CREATURE_FAMILIAR, 16 + random(7))
        end,

        [HERO_SPEC_BLADE_MASTER] = 
        function(object)
            AddObjectCreatures(object, CREATURE_PIXIE, 10 + random(4))
        end
    },
    
    ByHero =
    {
        ["Wulfstan"] =
        function(object)
            AddObjectCreatures(object, CREATURE_BROWLER, 3)
        end,
        
        ["Kujin"] =
        function(object)
            AddObjectCreatures(object, CREATURE_SHAMAN, 2)
        end,
    },

    Init =
    function()
        AddHeroEvent.AddListener("BTD_RMG_army_generation_add_hero",
        function(hero)
            local hero_spec = Hero.Params.Spec(hero)
            for spec, func in Generation.BySpec do
                if spec == hero_spec then
                    local object = GetHeroTown(hero) or hero
                    startThread(Generation.BySpec[spec], object)
                    break
                end
            end
            --
            for _hero, func in Generation.ByHero do
                if hero == _hero then
                    local object = GetHeroTown(hero) or hero
                    startThread(Generation.ByHero[_hero], object)
                end
            end
        end)
    end
}

startThread(Generation.Init)