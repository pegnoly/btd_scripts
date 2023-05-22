doFile("/scripts/RMG/advmap/Objects/NewObjects/StatueOfRevelation/script.lua")
doFile("/scripts/RMG/advmap/Objects/NewObjects/SunRiderMonument/script.lua")
doFile("/scripts/RMG/advmap/Objects/NewObjects/WarmenHouse/script.lua")
doFile("/scripts/RMG/advmap/Objects/NewObjects/KnowledgeMegalith/script.lua")

BTD_Objects =
{
    Handlers = 
	{
		[BTD_STATUE_OF_REVELATION] = 
		function(object)
			Touch.DisableObject(object)
			Touch.SetFunction(object, "_BTD_statue_of_revelation_touch",
			function(hero, statue)
				if not StatueOfRevelation.used_by_hero[hero] then
					StatueOfRevelation.used_by_hero[hero] = 1
					GiveHeroBattleBonus(hero, HERO_BATTLE_BONUS_INITIATIVE, 1)
				else
					ShowFlyingSign(StatueOfRevelation.path.."already_used.txt", statue, GetObjectOwner(hero), 6.0)
				end    
			end)
		end,
		
		[BTD_SUN_RIDER_MONUMENT] = 
		function(object)
			Touch.DisableObject(object)
			Touch.SetFunction(object, "_BTD_sun_rider_monument_touch",
			function(hero, monument)
				if not SunRiderMonument.used_by_hero[hero] then
					SunRiderMonument.used_by_hero[hero] = 1
					GiveHeroBattleBonus(hero, HERO_BATTLE_BONUS_SPEED, 1)
				else
					ShowFlyingSign(SunRiderMonument.path.."already_used.txt", monument, GetObjectOwner(hero), 6.0)
				end    
			end)
		end,
		
		[BTD_WARMEN_HOUSE] = 
		function(object)
			Touch.DisableObject(object)
			Touch.SetFunction(object, "_BTD_warmen_house_touch",
			function(hero, house)
				local race = Hero.Params.Town(hero)
				if race == TOWN_STRONGHOLD then
					if not WarmenHouse.used_by_orc_hero[hero] then
						WarmenHouse.used_by_orc_hero[hero] = 1
						consoleCmd("@SetGameVar('"..hero.."_warmen_house_bonus', 'active')")
						local x, y, f = GetObjectPosition(hero)
						PlayVisualEffect("/Effects/_(Effect)/Spells/Warcry/Ralling Cry/FX_RallingCry.(Effect).xdb#xpointer(/Effect)", hero, "", 0, 0, 3, f, 0, GetPlayerFilter(GetObjectOwner(hero)))
						Play3DSoundForPlayers(GetPlayerFilter(GetObjectOwner(hero)), "/Sounds/_(Sound)/Spells/Warcry/RallingCry.xdb#xpointer(/Sound)", x, y, f)
					else
						ShowFlyingSign(WarmenHouse.path.."already_used.txt", house, GetObjectOwner(hero), 6.0)
					end
				else
					if not WarmenHouse.used_by_other_hero[hero] then
						WarmenHouse.used_by_other_hero[hero] = 1
						local exp_to_add = WarmenHouse.exp_amount + 
											(WarmenHouse.exp_amount * (GetHeroSkillMastery(hero, SKILL_LEARNING) * 0.05))
						GiveExp(hero, exp_to_add)
					else
						ShowFlyingSign(WarmenHouse.path.."already_used.txt", house, GetObjectOwner(hero), 6.0)
					end
				end      
			end)
		end,

		[BTD_KNOWLEDGE_MEGALITH] = 
		function(object)
      KnowledgeMegalith.used_by_hero[object] = {}
			Touch.DisableObject(object)
			Touch.SetFunction(object, "_BTD_knowledge_megalith_touch",
			function(hero, megalith)
				if not KnowledgeMegalith.used_by_hero[megalith][hero] then
					GiveExp(hero, KnowledgeMegalith.exp_amount)
					KnowledgeMegalith.used_by_hero[megalith][hero] = 1
					MarkObjectAsVisited(hero, megalith)
				else
					ShowFlyingSign(KnowledgeMegalith.path.."already_used.txt", megalith, GetObjectOwner(hero), 6.0)
				end
			end)
		end
	},

    Init = 
    function()
        MapLoadingEvent.AddListener("BTD_RMG_init_new_objects_event",
        function()
            for object, type in BTD_NewObjects do
                startThread(BTD_Objects.Handlers[type], object)
            end
        end)
    end
}

startThread(BTD_Objects.Init)
CombatConnection.combat_scripts_paths["warmen_house"] = "/scripts/RMG/advmap/Objects/NewObjects/WarmenHouse/combat.lua"