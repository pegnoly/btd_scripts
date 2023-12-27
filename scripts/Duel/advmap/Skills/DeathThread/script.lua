death_thread =
{
  speed_bonus = 1, -- 
  affected_heroes_for_hero = {},
  base_distance = 20,
}

AddHeroEvent.AddListener('death_thread_add_hero_event',
function(hero)
    errorHook(function ()
        print("<color=red>Error: <color=green> DeathThread duel add hero.")
    end)
    startThread(
    function()
        death_thread.affected_heroes_for_hero[%hero] = {}
        while 1 do
            if IsHeroAlive(%hero) then
                local temp_name = GetHeroTown(%hero) or %hero
                for player = PLAYER_1, PLAYER_8 do
                    if Player.IsActive(player) and (GetObjectOwner(%hero) ~= player) and (GetPlayerTeam(GetObjectOwner(%hero)) ~= GetPlayerTeam(player)) then
                        for i, c_hero in GetPlayerHeroes(player) do
                            if not death_thread.affected_heroes_for_hero[%hero][c_hero] then
                                if HasHeroSkill(%hero, NECROMANCER_FEAT_DEATH_TREAD) then
                                    local dist = Object.Distance(c_hero, temp_name)
                                    if dist and dist <= death_thread.base_distance then
                                        death_thread.affected_heroes_for_hero[%hero][c_hero] = 1
                                        GiveHeroBattleBonus(c_hero, HERO_BATTLE_BONUS_SPEED, -1)
                                    end
                                end
                            else
                                if not HasHeroSkill(%hero, NECROMANCER_FEAT_DEATH_TREAD) then
                                    death_thread.affected_heroes_for_hero[%hero][c_hero] = nil
                                    GiveHeroBattleBonus(c_hero, HERO_BATTLE_BONUS_SPEED, 1)
                                end
                                local dist = Object.Distance(c_hero, temp_name)
                                if dist and dist > death_thread.base_distance then
                                    death_thread.affected_heroes_for_hero[%hero][c_hero] = nil
                                    GiveHeroBattleBonus(c_hero, HERO_BATTLE_BONUS_SPEED, 1)
                                end
                            end
                        end
                    end
                end
            end
        sleep()
        end
    end)
end)