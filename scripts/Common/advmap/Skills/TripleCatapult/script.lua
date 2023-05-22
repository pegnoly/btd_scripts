triple_catapult =
{
  active_for_hero = {}
}

AddHeroEvent.AddListener("BTD_triple_catapult_add_hero_event",
function(hero)
  triple_catapult.active_for_hero[hero] = nil
  startThread(
  function()
    while 1 do
      if IsHeroAlive(%hero) then
        if not triple_catapult.active_for_hero[%hero] then
          if HasHeroSkill(%hero, DEMON_FEAT_TRIPLE_CATAPULT) then
            triple_catapult.active_for_hero[%hero] = 1
            consoleCmd("@SetGameVar('"..%hero.."_TRIPLE_CATAPULT', '1')")
          end
        else
          if not HasHeroSkill(%hero, DEMON_FEAT_TRIPLE_CATAPULT) then
            triple_catapult.active_for_hero[%hero] = nil
            consoleCmd("@SetGameVar('"..%hero.."_TRIPLE_CATAPULT', '')")
          end
        end
      end
      sleep()
    end
  end)
end)

CombatConnection.combat_scripts_paths['triple_catapult'] = '/scripts/Common/combat/Skills/TripleCatapult/script.lua'