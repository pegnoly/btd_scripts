-- новые механики карты.
--------------------------------------------------------------------------------
-- замена стеков.
stack_replacer =
{
  stacks_info =
  {
    common =
    {
--      ['fact_p1'] = {{tier = 1, func = function(n) return n * 2 - 15 end}},
--      ['fact_p2'] = {{tier = 1, func = function(n) return n * 2 - 15 end}},
--      ['arena_p1'] = {{tier = 6, func = function(n) return 10 end}},
--      ['arena_p2'] = {{tier = 6, func = function(n) return 10 end}},
--      ['witch_p1'] = {{tier = 1, func = function(n) return n * 2 end}, {tier = 5, func = function(n) return 10 end}},
--      ['witch_p2'] = {{tier = 1, func = function(n) return n * 2 end}, {tier = 5, func = function(n) return 10 end}},
--      --
--      ['l7_p1_01'] = {{tier = 1, func = function(n) return 100 end}},
--      ['l7_p1_02'] = {{tier = 1, func = function(n) return 100 end}},
--      ['l7_p1_03'] = {{tier = 1, func = function(n) return 200 end}, {tier = 5, func = function(n) return 50 end}},
--      ['l7_p2_01'] = {{tier = 1, func = function(n) return 100 end}},
--      ['l7_p2_02'] = {{tier = 1, func = function(n) return 100 end}},
--      ['l7_p2_03'] = {{tier = 1, func = function(n) return 200 end}, {tier = 5, func = function(n) return 50 end}},
--      --
--      ['dwell_01_p1'] = {{tier = 2, func = function(n) return 30 end}, {tier = 3, func = function(n) return 20 end}},
--      ['dwell_01_p2'] = {{tier = 2, func = function(n) return 30 end}, {tier = 3, func = function(n) return 20 end}},
--      ['camp_p1'] = {{tier = 3, func = function(n) return 15 end}},
--      ['camp_p2'] = {{tier = 3, func = function(n) return 15 end}},
    },
    --  здесь регулируетс¤ число существ на пробивке артефактов
    player1 =
    {
      ['avenger_p1'] =
      {
        {tier = 1, func = function(n) return 50 end},
        {tier = 2, func = function(n) return 40 end},
        {tier = 3, func = function(n) return 30 end},
        {tier = 4, func = function(n) return 12 end},
        {tier = 5, func = function(n) return 10 end},
        {tier = 6, func = function(n) return 5 end},
        {tier = 7, func = function(n) return 2 end},
      },
    },
    --
    player2 =
    {
      ['avenger_p2'] =
      {
        {tier = 1, func = function(n) return 50 end},
        {tier = 2, func = function(n) return 40 end},
        {tier = 3, func = function(n) return 30 end},
        {tier = 4, func = function(n) return 12 end},
        {tier = 5, func = function(n) return 10 end},
        {tier = 6, func = function(n) return 5 end},
        {tier = 7, func = function(n) return 2 end},
      }
    }
  },

  Run =
  function()
    BlockGame()
    --
    for stack, info in stack_replacer.stacks_info.common do
      local id = table.pack(GetObjectCreaturesTypes(stack))[1]
      local count = GetObjectCreatures(stack, id)
      local town = GetCreatureTown(id)
      startThread(stack_replacer.Replace, stack, info, town, id, count)
    end
    --
    for stack, info in stack_replacer.stacks_info.player1 do
      local id = table.pack(GetObjectCreaturesTypes(stack))[1]
      local count = GetObjectCreatures(stack, id)
      local town = GetPlayerRace(PLAYER_2)
      startThread(stack_replacer.Replace, stack, info, town, id, count)
    end
    --
    for stack, info in stack_replacer.stacks_info.player2 do
      local id = table.pack(GetObjectCreaturesTypes(stack))[1]
      local count = GetObjectCreatures(stack, id)
      local town = GetPlayerRace(PLAYER_1)
      startThread(stack_replacer.Replace, stack, info, town, id, count)
    end
    sleep(20)
    --startThread(stack_balancer.Init)
  end,

  Replace =
  function(stack, info, town, id, count)
    for i, repl_info in info do
      --
      local new_id, new_count = -1, -1
      if town ~= TOWN_NO_TYPE then
        --print('stack: ', stack, ', tier: ', repl_info.tier, ', table: ', TIER_TABLES[town][repl_info.tier], ' except ', TIER_TABLES[town][repl_info.tier][1])
        --new_id = GetRandFromT_E(TIER_TABLES[town][repl_info.tier][1], TIER_TABLES[town][repl_info.tier])
        new_id = TIER_TABLES[town][repl_info.tier][1]
      else
        local rand_town = random(8)
        --new_id = GetRandFromT_E(TIER_TABLES[rand_town][repl_info.tier][1], TIER_TABLES[rand_town][repl_info.tier])
        new_id = TIER_TABLES[rand_town][repl_info.tier][1]
      end
      --print("new_id: ", new_id)
      new_count = repl_info.func(count)
      --print("new_count: ", new_count)
      AddObjectCreatures(stack, new_id, new_count)
      if GetObjectCreatures(stack, CREATURE_SNOW_APE) > 0 then
        while GetObjectCreatures(stack, new_id) ~= new_count do
          sleep()
        end
        RemoveObjectCreatures(stack, CREATURE_SNOW_APE, 9999)
        while GetObjectCreatures(stack, CREATURE_SNOW_APE) ~= 0 do
          sleep()
        end
      end
    end
    --
  end
}

--stack_balancer =
--{
--  Init =
--  function()
--     for i, creature in GetObjectNamesByType("CREATURE") do
--       for slot = 0, 6 do
--         local id, count = GetObjectArmySlotCreature(creature, slot)
--         if not (id == 0 or count == 0) then
--           local expected_count = ceil(count * AVERAGE_POWERS[GetCreatureTier(id)] / GetCreaturePower(id))
--           --print("count ", count, " expected ", expected_count)
--           if expected_count > count then
--             AddObjectCreatures(creature, id, expected_count - count, slot)
--           elseif expected_count < count then
--             RemoveObjectCreatures(creature, id, count - expected_count, slot)
--           end
--         end
--       end
--     end
--     UnblockGame()
--  end
--}
--
--stack_generator =
--{
--  Init =
--  function()
--    --
--    for i = 1, 2 do
--      local x, y, z = RegionToPoint("dwarren_p"..i)
--      if random(2) == 0 then
--        CreateMonster("dwarren_0"..i, CREATURE_WARLORD, 10, x, y, z, 3, 1, 0, 1)
--        while not IsObjectExists("dwarren_0"..i) do
--          sleep()
--        end
--        AddObjectCreatures("dwarren_0"..i, CREATURE_THUNDER_THANE, 10)
--        AddObjectCreatures("dwarren_0"..i, CREATURE_FLAME_MAGE, 10)
--        AddObjectCreatures("dwarren_0"..i, CREATURE_FLAME_KEEPER, 10)
--      else
--        CreateMonster("dwarren_0"..i, CREATURE_FLAME_MAGE, 12, x, y, z, 3, 1, 0, 1)
--        while not IsObjectExists("dwarren_0"..i) do
--          sleep()
--        end
--        AddObjectCreatures("dwarren_0"..i, CREATURE_FLAME_KEEPER, 12)
--        AddObjectCreatures("dwarren_0"..i, CREATURE_MAGMA_DRAGON, 5)
--        AddObjectCreatures("dwarren_0"..i, CREATURE_LAVA_DRAGON, 5)
--      end
--    end
--  end
--}

MapLoadingEvent.AddListener("btd_stack_replacer_event",
function()
  startThread(stack_replacer.Run)
  --startThread(stack_generator.Init)
end)
