grail_vision =
{
  active_for_hero = {}
}

AddHeroEvent.AddListener("BTD_grail_vision_add_hero_event",
function(hero)
  grail_vision.active_for_hero[hero] = nil
  startThread(
  function()
    while 1 do
      if IsHeroAlive(%hero) then
        if not grail_vision.active_for_hero[%hero] then
          if HasHeroSkill(%hero, KNIGHT_FEAT_GRAIL_VISION) then
            grail_vision.active_for_hero[%hero] = 1
            consoleCmd("@SetGameVar('"..%hero.."_GRAIL_VISION', '1')")
          end
        else
          if not HasHeroSkill(%hero, KNIGHT_FEAT_GRAIL_VISION) then
            grail_vision.active_for_hero[%hero] = nil
            consoleCmd("@SetGameVar('"..%hero.."_GRAIL_VISION', '')")
          end
        end
      end
      sleep()
    end
  end)
end)

RespawnHeroEvent.AddListener("BTD_common_grail_vision_respawn_hero_event",
function(hero)
    if HasHeroSkill(hero, KNIGHT_FEAT_GRAIL_VISION) then
        consoleCmd("@SetGameVar('"..hero.."_GRAIL_VISION', '1')")
    end   
end)

CombatConnection.combat_scripts_paths['grail_vision'] = '/scripts/Common/combat/Skills/GrailVision/script.lua'