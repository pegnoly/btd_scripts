forest_leader_rmg =
{
  limit_for_player = 3,
  grow_amount = 10,
  
  limits_per_player = {},
  used_for_hero = {}
}

MapLoadingEvent.AddListener("BTD_rmg_forest_leader_init",
function()
    for player = PLAYER_1, PLAYER_8 do
        forest_leader_rmg.limits_per_player[player] = forest_leader_rmg.limit_for_player
    end
end)

AddHeroEvent.AddListener("BTD_rmg_forest_leader_add_hero",
function(hero)
    startThread(
    function()
        local player = GetObjectOwner(%hero)
        while 1 do
           if forest_leader_rmg.limits_per_player[player] == 0 then
              return
           end
           if IsHeroAlive(%hero) then
              if not forest_leader_rmg.used_for_hero[%hero] then
                 if HasHeroSkill(%hero, RANGER_FEAT_FOREST_GUARD_EMBLEM) then
                    forest_leader_rmg.used_for_hero[%hero] = 1
                    forest_leader_rmg.limits_per_player[player] = forest_leader_rmg.limits_per_player[player] - 1
                    startThread(Hero.CreatureInfo.DefaultGrow, %hero, TOWN_PRESERVE, 2, forest_leader_rmg.grow_amount)
                    return
                 end
              end
           end
           sleep()
        end
    end)
end)