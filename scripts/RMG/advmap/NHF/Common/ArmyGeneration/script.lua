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
        end
    },
    
    ByHero =
    {
        ["Wulfstan"] =
        function(hero)
            AddHeroCreatures(hero, CREATURE_BROWLER, 2)
        end,
        
        ["Kujin"] =
        function(hero)
            AddHeroCreatures(hero, CREATURE_SHAMAN, 1)
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