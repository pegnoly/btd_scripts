--- Gives 'Summon Elementals' spell when 'Elemental Balance' skill received 

elemental_balance_text_path = "/scripts/RMG/advmap/Skills/ElementalBalance/spell_learned.txt"

elemental_balance_rmg_func = function(hero)
    startThread(
    function()
        local hero = %hero
        while 1 do
            if IsHeroAlive(hero) then
                if not KnowHeroSpell(hero, SPELL_SUMMON_ELEMENTALS) and
                    HasHeroSkill(hero, KNIGHT_FEAT_ELEMENTAL_BALANCE)
                then
                    TeachHeroSpell(hero, SPELL_SUMMON_ELEMENTALS)
                    MessageQueue.AddMessage(GetObjectOwner(hero), elemental_balance_text_path, hero, 3)
                end
            end

            sleep()
        end
    end)
end

MapLoadingEvent.AddListener("BTD_RMG_elemental_balance_rmg_init", 
function()
    for _, hero in GetObjectNamesByType('HERO') do
        elemental_balance_rmg_func(hero)
    end
end)


AddHeroEvent.AddListener("BTD_RMG_elemental_balance_rmg_add_hero_event", elemental_balance_rmg_func)