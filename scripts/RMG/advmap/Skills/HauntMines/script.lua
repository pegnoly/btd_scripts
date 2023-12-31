HERO_SKILL_GHOST_MINES = 223

haunt_mines_rmg = {
    common_mines = {},
    rare_mines = {},
    gold_mines = {},
    abandoned_mines = {},

    common_mine_mult = 2,
    rare_mine_mult = 4,
    gold_mine_mult = 12,
    abandon_mine_mult = 24,

    limit_per_hero_level = 5,

    active_for_hero = {},
    current_count_for_hero = {}
}

MapLoadingEvent.AddListener("BTD_RMG_haunt_mines_init",
function()
    for i, type in {'SAWMILL', 'ORE_PIT'} do
        for j, mine in GetObjectNamesByType(type) do
            print("common mine added: ", mine)
            haunt_mines_rmg.common_mines[mine] = PLAYER_NONE    
        end
    end
    --
    for i, type in {'ALCHEMIST_LAB', 'CRYSTAL_CAVERN', 'GEM_POND', 'SULFUR_DUNE'} do
        for j, mine in GetObjectNamesByType(type) do
            print("rare mine added: ", mine)
            haunt_mines_rmg.rare_mines[mine] = PLAYER_NONE    
        end
    end
    --
    for i, mine in GetObjectNamesByType('GOLD_MINE') do
        print("gold mine added: ", mine)
        haunt_mines_rmg.gold_mines[mine] = PLAYER_NONE
    end
    --
    for i, mine in GetObjectNamesByType('ABANDONED_MINE') do
        print("abandoned mine added: ", mine)
        haunt_mines_rmg.abandoned_mines[mine] = PLAYER_NONE
    end
end)

AddHeroEvent.AddListener("BTD_RMG_haunt_mines_add_hero",
function(hero)
    haunt_mines_rmg.active_for_hero[hero] = nil
    haunt_mines_rmg.current_count_for_hero[hero] = -1
    if Hero.Params.Town(hero) ~= TOWN_NECROMANCY then
        return
    end
    startThread(
    function()
        while 1 do
            if IsHeroAlive(%hero) then
                if not haunt_mines_rmg.active_for_hero[%hero] then
                    if HasHeroSkill(%hero, HERO_SKILL_GHOST_MINES) then
                        haunt_mines_rmg.active_for_hero[%hero] = 1
                    end
                else
                    if not HasHeroSkill(%hero, HERO_SKILL_GHOST_MINES) then
                        haunt_mines_rmg.active_for_hero[%hero] = nil
                        consoleCmd("@SetGameVar('"..%hero.."_HAUNT_MINES_GHOSTS_COUNT', -1)")
                    else
                        local curr_count = HauntMinesRMG_CalcGhostsMaxCount(%hero)
                        if curr_count ~= haunt_mines_rmg.current_count_for_hero[%hero] then
                            haunt_mines_rmg.current_count_for_hero[%hero] = curr_count
                            consoleCmd("@SetGameVar('"..%hero.."_HAUNT_MINES_GHOSTS_COUNT', "..curr_count..")")
                        end
                    end
                end
            end
            sleep()
        end
    end)
end)

function HauntMinesRMG_CalcGhostsMaxCount(hero)
    local player = GetObjectOwner(hero)
    local count = 0
    for mine, _ in haunt_mines_rmg.common_mines do
        if GetObjectOwner(mine) == player then
            count = count + haunt_mines_rmg.common_mine_mult
        end
    end
    --
    for mine, _ in haunt_mines_rmg.rare_mines do
        if GetObjectOwner(mine) == player then
            count = count + haunt_mines_rmg.rare_mine_mult
        end
    end
    --
    for mine, _ in haunt_mines_rmg.gold_mines do
        if GetObjectOwner(mine) == player then
            count = count + haunt_mines_rmg.gold_mine_mult
        end
    end
    --
    for mine, _ in haunt_mines_rmg.abandoned_mines do
        if GetObjectOwner(mine) == player then
            count = count + haunt_mines_rmg.abandon_mine_mult
        end
    end
    --
    local limit = GetHeroLevel(hero) * haunt_mines_rmg.limit_per_hero_level
    if count > limit then
        count = limit
    end
    return count
end

CombatConnection.combat_scripts_paths['haunt_mines_common'] = '/scripts/Common/combat/Skills/HauntMines/script.lua'