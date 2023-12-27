--- 25.05.2023 - effect changed.

dark_ritual =
{
    active_for_hero = {}
}

AddHeroEvent.AddListener("BTD_duel_dark_ritual_add_hero_event",
function(hero)
    dark_ritual.active_for_hero[hero] = nil
    startThread(
    function()
        while 1 do
            if IsHeroAlive(%hero) then
                if not dark_ritual.active_for_hero[%hero] then
                    if HasHeroSkill(%hero, PERK_DARK_RITUAL) then
                        dark_ritual.active_for_hero[%hero] = 1
                        consoleCmd("@SetGameVar('"..%hero.."_DARK_RITUAL', '1')")
                    end
                else
                    if not HasHeroSkill(%hero, PERK_DARK_RITUAL) then
                        dark_ritual.active_for_hero[%hero] = nil
                        consoleCmd("@SetGameVar('"..%hero.."_DARK_RITUAL', '')")
                    end
                end
            end
            sleep()
        end
    end)
end)

CombatConnection.combat_scripts_paths['dark_ritual'] = '/scripts/Duel/combat/DarkRitual/script.lua'