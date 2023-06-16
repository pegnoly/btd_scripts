defend_us_all =
{
  active_for_hero = {}
}

AddHeroEvent.AddListener("BTD_defend_us_all_add_hero_event",
function(hero)
    while not defend_us_all do
      sleep()
    end
    defend_us_all.active_for_hero[hero] = nil
    startThread(
    function()
        while 1 do
        if IsHeroAlive(%hero) then
            if not defend_us_all.active_for_hero[%hero] then
                if HasHeroSkill(%hero, HERO_SKILL_DEFEND_US_ALL) then
                    defend_us_all.active_for_hero[%hero] = 1
                    consoleCmd("@SetGameVar('"..%hero.."_DEFEND_US_ALL', '1')")
                end
                else
                    if not HasHeroSkill(%hero, HERO_SKILL_DEFEND_US_ALL) then
                        defend_us_all.active_for_hero[%hero] = nil
                        consoleCmd("@SetGameVar('"..%hero.."_DEFEND_US_ALL', '')")
                    end
                end
            end
            sleep()
        end
    end)
end)

RespawnHeroEvent.AddListener("BTD_common_defend_us_all_respawn_hero_event",
function(hero)
    if HasHeroSkill(hero, HERO_SKILL_DEFEND_US_ALL) then
        consoleCmd("@SetGameVar('"..hero.."_DEFEND_US_ALL', '1')")
    end   
end)

CombatConnection.combat_scripts_paths['defend_us_all'] = '/scripts/Common/combat/Skills/DefendUsAll/script.lua'