mguild_rmg = {
    heroes_scroll_receive_info = {},
    ability_active_for_hero = {},
    towns_statuses = {},
    hero_town_connection_info = {},
    current_scroll_for_hero = {},
    path = "/scripts/RMG/advmap/Towns/Common/MagicGuild/SpellDialog/"
}

MapLoadingEvent.AddListener("BTD_RMG_mguilds_init",
function()
    for i, town in GetObjectNamesByType("TOWN") do
        if GetTownRace(town) ~= TOWN_STRONGHOLD then
            mguild_rmg.towns_statuses[town] = {
                [4] = LVL_STATUS_NOT_UPGRADED,
                [5] = LVL_STATUS_NOT_UPGRADED
            }
        end
    end
    sleep()
    startThread(RMG_MGuildUpgradesCheckThread)
    startThread(RMG_MGuildHeroesInTownCheckThread)
    startThread(RMG_MGuildAbilityActivationThread)
end)

AddHeroEvent.AddListener("BTD_RMG_mguild_init_hero_scroll_info",
function(hero)
    print("MGuild: init ", hero)
    mguild_rmg.heroes_scroll_receive_info[hero] = {}
end)

function RMG_MGuildUpgradesCheckThread()
    while 1 do
        for town, status_info in mguild_rmg.towns_statuses do
            local guild_level = GetTownBuildingLevel(town, TOWN_BUILDING_MAGIC_GUILD)
            if guild_level >= 4 and status_info[guild_level] == LVL_STATUS_NOT_UPGRADED then
                mguild_rmg.towns_statuses[town][guild_level] = LVL_STATUS_PENDING
            end
        end
        sleep()
    end
end

function RMG_MGuildHeroesInTownCheckThread() 
    while 1 do
        for town, status_info in mguild_rmg.towns_statuses do
            for lvl, status in status_info do
                if status == LVL_STATUS_PENDING then
                    for i, hero in GetPlayerHeroes(GetObjectOwner(town)) do
                        if IsHeroInTown(hero, town, 1, 1) then
                            if MGUILD_DEBUG_LEVEL == 1 then
                                print("Trying to give scroll to hero, ", hero)
                            end
                            startThread(RMG_MGuildGivePossibleScrolls, hero, town, lvl)
                        end
                    end
                end
            end
        end
        sleep()
    end
end

function RMG_MGuildGivePossibleScrolls(hero, town, scroll_lvl)
    if not mguild_rmg.heroes_scroll_receive_info[hero] then
        -- mguild_rmg.heroes_scroll_receive_info[hero] = {
        --     [104] = nil,
        --     [106] = nil
        -- }
        return
    end
    --print("Trying to give scrolls to ", hero)
    local mastery = scroll_lvl == 4 and 2 or 3
    for i, school in SCHOOLS_BY_TOWNS[GetTownRace(town)] do
        local scroll = SCROLLS_BY_SCHOOLS[school][scroll_lvl]
        --print("scroll: ", scroll)
        --print("receive info: ", mguild_rmg.heroes_scroll_receive_info[hero][scroll])
        if not mguild_rmg.heroes_scroll_receive_info[hero][scroll] then
            local skill = SKILLS_BY_SCHOOLS[SCHOOLS_BY_SCROLLS[scroll]]
            --print("skill: ", skill)
            if GetHeroSkillMastery(hero, skill) >= mastery then
                --print("Can receive scroll")
                GiveArtefact(hero, scroll, 1)
                mguild_rmg.heroes_scroll_receive_info[hero][scroll] = 1
                if not mguild_rmg.hero_town_connection_info[hero] then
                    mguild_rmg.hero_town_connection_info[hero] = town
                end
            end
        end
    end
end

function CanActivateScroll(hero, scroll) 
    if SCROLL_ACTIVATION_CONDITONS[scroll](hero) then
        return 1
    end
    return nil
end

function HasAnyScroll(hero)
    for scroll = SCROLL_LIGHT_L4, SCROLL_DESTRUCTIVE_L5 do
        if HasArtefact(hero, scroll, 1) then
            return scroll
        end
    end
    return nil
end

function RMG_MGuildAbilityActivationThread()
    while 1 do
        for player = PLAYER_1, PLAYER_8 do
            if GetPlayerState(player) == PLAYER_ACTIVE and IsAIPlayer(player) == 0 then
                for i, hero in GetPlayerHeroes(player) do
                    if not mguild_rmg.ability_active_for_hero[hero] then
                        local scroll = HasAnyScroll(hero)
                        if scroll and CanActivateScroll(hero, scroll) then
                            mguild_rmg.current_scroll_for_hero[hero] = scroll
                            mguild_rmg.ability_active_for_hero[hero] = 1
                            ControlHeroCustomAbility(hero, CUSTOM_ABILITY_LEARN_SCROLL_SPELL, CUSTOM_ABILITY_ENABLED)
                        end
                    else
                        if (not HasAnyScroll(hero)) or (not CanActivateScroll(hero, mguild_rmg.current_scroll_for_hero[hero])) then
                            mguild_rmg.ability_active_for_hero[hero] = nil
                            ControlHeroCustomAbility(hero, CUSTOM_ABILITY_LEARN_SCROLL_SPELL, CUSTOM_ABILITY_NOT_PRESENT)
                        end
                    end
                end
            end
        end
        sleep()
    end
end

CustomAbility.callbacks[CUSTOM_ABILITY_LEARN_SCROLL_SPELL] = 
function(hero)
    local scroll = -1
    for art = SCROLL_LIGHT_L4, SCROLL_DESTRUCTIVE_L5 do
        if HasArtefact(hero, art, 1) then
            scroll = art
            break
        end
    end
    local school = SCHOOLS_BY_SCROLLS[scroll]
    local level = -1
    for lvl, scr in SCROLLS_BY_SCHOOLS[school] do
        if scroll == scr then
            level = lvl
            break
        end
    end
    local spells_to_learn, n = {}, 0
    for i, spell in SPELLS_BY_SCHOOL_LEVEL[school][level] do
        if not KnowHeroSpell(hero, spell) then
            n = n + 1
            spells_to_learn[n] = spell
        end
    end
    if n == 0 then 
        startThread(MCCS_MessageBoxForPlayers, GetObjectOwner(hero), mguild_rmg.path.."all_spells_known.txt")
        return
    end
    --
    local index = 1
    while index <= n do
        if MCCS_QuestionBoxForPlayers(GetObjectOwner(hero), {
            mguild_rmg.path.."main_text.txt";  hero_name = Hero.Params.Name(hero), spell_name = Spell.Params.Name(spells_to_learn[index])
        }) then
            local is_ok, status = pcall(TryToLearnSpell, hero, spells_to_learn[index], level)
            if is_ok then
                if status == LEARN_STATUS_SUCCESS then
                    startThread(SpellLearnedCallback, hero)
                    return
                elseif status == LEARN_STATUS_NOT_ENOUGH_GOLD then
                    return
                else
                    index = index + 1
                end
            end
        else
            index = index + 1
        end
        sleep()
    end           
end

function TryToLearnSpell(hero, spell, level)
    if MCCS_QuestionBoxForPlayers(GetObjectOwner(hero), {
        mguild_rmg.path.."try_to_learn.txt"; spell_name = Spell.Params.Name(spell), cost = COST_BY_LEVEL[level]
    }) then
        local gold = GetPlayerResource(GetObjectOwner(hero), GOLD)
        if gold >= COST_BY_LEVEL[level] then
            SetPlayerResource(GetObjectOwner(hero), GOLD, gold - COST_BY_LEVEL[level])
            RemoveArtefact(hero, mguild_rmg.current_scroll_for_hero[hero])
            Hero.SpellInfo.TeachSpell(hero, spell)
            return LEARN_STATUS_SUCCESS
        else
            startThread(MCCS_MessageBoxForPlayers, GetObjectOwner(hero), mguild_rmg.path.."not_enough_gold.txt")
            return LEARN_STATUS_NOT_ENOUGH_GOLD
        end
    else
        return LEARN_STATUS_SKIPPED
    end
end

function SpellLearnedCallback(hero)
    local town = mguild_rmg.hero_town_connection_info[hero]
    mguild_rmg.towns_statuses[town] = {[4] = LVL_STATUS_GIVEN, [5] = LVL_STATUS_GIVEN}
    for i, _hero in GetPlayerHeroes(GetObjectOwner(hero)) do
        local scrolls_count = 0
        for art = SCROLL_LIGHT_L4, SCROLL_DESTRUCTIVE_L5 do
            if HasArtefact(_hero, art) then
                scrolls_count = scrolls_count + 1
                RemoveArtefact(_hero, art)
            end
        end
        if scrolls_count == 0 then
            return
        else
            local x, y, f = GetObjectPosition(hero)
            PlayVisualEffect(
                "/Effects/_(Effect)/"..FX.Effects["Unsummon"]..".xdb#xpointer(/Effect)", _hero, "", 0, 0, 3, f, 0, 
                GetPlayerFilter(GetObjectOwner(hero))
            )
            if scrolls_count == 1 then
                ShowFlyingSign(mguild_rmg.path.."scroll_dissapeared.txt", _hero, GetObjectOwner(hero), 6.0)
            else
                ShowFlyingSign(mguild_rmg.path.."scrolls_dissapeared.txt", _hero, GetObjectOwner(hero), 6.0)
            end
        end
    end
end