catapult_rmg =
{
    active_for_hero = {}
}

AddHeroEvent.AddListener("BTD_RMG_catapult_rmg_add_hero_event",
function(hero)
    catapult_rmg.active_for_hero[hero] = nil
    startThread(
    function()
        while 1 do
        if IsHeroAlive(%hero) then
            if not catapult_rmg.active_for_hero[%hero] then
                if HasHeroSkill(%hero, PERK_CATAPULT) then
                    catapult_rmg.active_for_hero[%hero] = 1
                    consoleCmd("@SetGameVar('"..%hero.."_CATAPULT', '1')")
                end
                else
                    if not HasHeroSkill(%hero, PERK_CATAPULT) then
                        catapult_rmg.active_for_hero[%hero] = nil
                        consoleCmd("@SetGameVar('"..%hero.."_CATAPULT', '')")
                    end
                end
            end
            sleep()
        end
    end)
end)

CombatConnection.combat_scripts_paths['catapult_rmg'] = '/scripts/RMG/combat/Skills/Catapult/script.lua'