navigation_common =
{
    path = "/scripts/Common/advmap/Skills/Navigation/",
    stat_amount = 2,
    stat_for_hero = {}
}

while not CustomAbility and CUSTOM_ABILITY_HERO do 
    sleep()
end

CustomAbility.callbacks["navigation"] = {
    question = navigation_common.path.."wanna_use.txt",
    func = function(hero)
        ---@type PlayerID
        local owner = GetObjectOwner(hero)
        ---@type HeroStatType
        local stat_selected
        if Navigation_SelectStatType(owner) then
            stat_selected = Navigation_SelectMightStat(hero, owner)
        else
            stat_selected = Navigation_SelectMagicStat(hero, owner)
        end
        navigation_common.stat_for_hero[hero] = stat_selected
        Hero.Stats.Change(hero, stat_selected, navigation_common.stat_amount)
        CustomAbility.callbacks_for_hero[CUSTOM_ABILITY_HERO][hero]["navigation"] = nil
    end
}

function Navigation_SelectStatType(owner)
    local is_might_stat = MCCS_QuestionBoxForPlayers(owner, navigation_common.path.."select_stat_type.txt")
    return is_might_stat
end

function Navigation_SelectMightStat(hero, owner)
    if MCCS_QuestionBoxForPlayers(owner, navigation_common.path.."select_might_stat.txt") then
        return STAT_ATTACK
    end
    return STAT_DEFENCE
end

function Navigation_SelectMagicStat(hero, owner)
    if MCCS_QuestionBoxForPlayers(owner, navigation_common.path.."select_magic_stat.txt") then
        return STAT_SPELL_POWER
    end
    return STAT_KNOWLEDGE
end