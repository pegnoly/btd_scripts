guardian_angel_rmg =
{
    active_for_hero = {}
}

AddHeroEvent.AddListener("BTD_RMG_guardian_angel_rmg_add_hero_event",
function(hero)
    guardian_angel_rmg.active_for_hero[hero] = nil
    startThread(
    function()
        while 1 do
            if IsHeroAlive(%hero) then
                if not guardian_angel_rmg.active_for_hero[%hero] then
                    if HasHeroSkill(%hero, KNIGHT_FEAT_GUARDIAN_ANGEL) then
                        guardian_angel_rmg.active_for_hero[%hero] = 1
                        consoleCmd("@SetGameVar('"..%hero.."_GUARDIAN_ANGEL', '1')")
                    end
                else
                    if not HasHeroSkill(%hero, KNIGHT_FEAT_GUARDIAN_ANGEL) then
                        guardian_angel_rmg.active_for_hero[%hero] = nil
                        consoleCmd("@SetGameVar('"..%hero.."_GUARDIAN_ANGEL', '')")
                    end
                end
            end
            sleep()
        end
    end)
end)

RespawnHeroEvent.AddListener("BTD_RMG_guardian_angel_respawn_hero_event",
function(hero)
    if HasHeroSkill(hero, KNIGHT_FEAT_GUARDIAN_ANGEL) then
        consoleCmd("@SetGameVar('"..hero.."_GUARDIAN_ANGEL', '1')")
    end   
end)