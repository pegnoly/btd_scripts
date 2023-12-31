disguise_and_reckon_duel =
{
    creatures_replace = {
      [CREATURE_BLADE_JUGGLER] = 324,
      [CREATURE_WAR_DANCER] = 325,
      [CREATURE_BLADE_SINGER] = 326
    },
    specs_replace = {
      [HERO_SPEC_BLADE_MASTER] = {
        [CREATURE_BLADE_JUGGLER] = {[18] = 300, [20] = 301, [22] = 302, [24] = 303, [26] = 304, [28] = 305, [30] = 306, [32] = 307},
        [CREATURE_WAR_DANCER] = {[18] = 308, [20] = 309, [22] = 310, [24] = 311, [26] = 312, [28] = 313, [30] = 314, [32] = 315},
        [CREATURE_BLADE_SINGER] = {[18] = 316, [20] = 317, [22] = 318, [24] = 319, [26] = 320, [28] = 321, [30] = 322, [32] = 323}
      }
    }
}

NewDayEvent.AddListener("btd_duel_disguise_and_reckon_new_day_listener",
function(day)
    if day == BTD_duel_day_sequence.fight_day then
        for hero, alive_status in AdvMapHeroesInfo.alive_heroes do
           if hero and alive_status == HERO_CONDITION_ALIVE and HasHeroSkill(hero, RANGER_FEAT_DISGUISE_AND_RECKON) then
              consoleCmd("@SetGameVar('"..hero.."_DISGUISE_AND_RECKON', 'active')")
              local spec = Hero.Params.Spec(hero)
              if disguise_and_reckon_duel.specs_replace[spec] then
                  local level, spec_level = GetHeroLevel(hero), 0
                  --
                  for i, lvl in {18, 20, 22, 24, 26, 28, 30, 32} do
                      if level <= lvl then
                          spec_level = lvl
                          break
                      end
                  end
                  --
                  print("d'n reckon spec lvl: ", spec_level)
                  for creature, replace_info in disguise_and_reckon_duel.specs_replace[spec] do
                      local count = GetHeroCreatures(hero, creature)
                      if count > 0 then
                          RemoveHeroCreatures(hero, creature, count)
                          while GetHeroCreatures(hero, creature) ~= 0 do
                              sleep()
                          end
                          AddHeroCreatures(hero, replace_info[spec_level], count)
                      end
                  end
              else
                  for creature, replace_info in disguise_and_reckon_duel.creatures_replace do
                      local count = GetHeroCreatures(hero, creature)
                      if count > 0 then
                        RemoveHeroCreatures(hero, creature, count)
                        while GetHeroCreatures(hero, creature) ~= 0 do
                          sleep()
                        end
                        AddHeroCreatures(hero, replace_info, count)
                      end
                  end
              end  
           end
        end
    end
end)

CombatConnection.combat_scripts_paths['disguise_and_reckon_duel'] = '/scripts/Duel/combat/DisguiseAndReckon/script.lua'