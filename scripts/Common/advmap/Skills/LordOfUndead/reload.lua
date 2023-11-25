-- [#3 fix] 
function LordOfUndeadReload()
    for i, hero in GetObjectNamesByType("HERO") do
        if HasHeroSkill(hero, NECROMANCER_FEAT_LORD_OF_UNDEAD) then
            consoleCmd("@SetGameVar('"..hero.."_LORD_OF_UNDEAD', '1')")
        end
        if Hero.Params.Class(hero) == HERO_CLASS_NECROMANCER then
            consoleCmd("@SetGameVar('"..hero.."_NECROMANCY_LEVEL', "..GetHeroSkillMastery(hero, SKILL_NECROMANCY)..")")
        end 
    end
end

consoleCmd("@CombatConnection.combat_scripts_paths['lord_of_undead_common'] = '/scripts/Common/combat/Skills/LordOfUndead/script.lua'")
consoleCmd("@MapReloadEvent.AddListener('BTD_common_lord_of_undead_reload', LordOfUndeadReload)")