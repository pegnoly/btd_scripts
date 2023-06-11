--- 25.05.23 - moved from RMG to Common scripts

catapult_common =
{
    active_for_hero = {}
}

AddHeroEvent.AddListener("BTD_common_catapult_add_hero_event",
function(hero)
    catapult_common.active_for_hero[hero] = nil
    startThread(
    function()
        while 1 do
        if IsHeroAlive(%hero) then
            if not catapult_common.active_for_hero[%hero] then
                if HasHeroSkill(%hero, PERK_CATAPULT) then
                    catapult_common.active_for_hero[%hero] = 1
                    consoleCmd("@SetGameVar('"..%hero.."_CATAPULT', '1')")
                end
                else
                    if not HasHeroSkill(%hero, PERK_CATAPULT) then
                        catapult_common.active_for_hero[%hero] = nil
                        consoleCmd("@SetGameVar('"..%hero.."_CATAPULT', '')")
                    end
                end
            end
            sleep()
        end
    end)
end)
