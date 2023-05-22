resources =
{
  path = m_path.."Duel/Resources/",
  academy = {[0] = 30; 30, 20, 20, 20, 20, 7500}, -- ресурсы јкадемии
  -- fortress = {[0] = 10; 10, 4, 4, 4, 4}, -- ресурсы гномов
  dungeon = {[GOLD] = 7500}, -- золото Ћиги
}

NewDayEvent.AddListener('btd_duel_fourth_day_res_event',
function(day)
  if day == BTD_SPECIAL_DAY then
    --Calibrate()
    for player = PLAYER_1, PLAYER_2 do
      local hero = GetPlayerHeroes(player)[0]
      local race = Hero.Params.Town(hero)
      if race == TOWN_ACADEMY then
        startThread(MCCS_MessageBoxForPlayers, player, resources.path.."academy.txt")
        for res, amount in resources.academy do
          Resource.Change(hero, res, amount)
          sleep(7)
        end
      elseif race == TOWN_FORTRESS then
        startThread(MCCS_MessageBoxForPlayers, player, resources.path.."fortress.txt")
--        for res, amount in resources.fortress do
--          MCCS_ChangeHeroResource(hero, res, amount)
--          sleep(7)
--        end
      elseif race == TOWN_DUNGEON then
        startThread(MCCS_MessageBoxForPlayers, player, resources.path.."dungeon.txt")
        for res, amount in resources.dungeon do
          Resource.Change(hero, res, amount)
          sleep(7)
        end
      elseif race == TOWN_NECROMANCY then
        startThread(Dialog.NewDialog, necro_army_add_dialog, hero, player)
      elseif race == TOWN_HEAVEN then
        startThread(Dialog.NewDialog, human_army_add_dialog, hero, player)
      elseif race == TOWN_PRESERVE then
        startThread(MCCS_MessageBoxForPlayers, player, rtext("Ќе забудьте назначить закл€тых врагов!"))
      else
        startThread(SkipTurnMessage, player)
      end
      --startThread(SkipTurnMessage, player)
    end
  end
end)

-- п€тый день - доп войска
army_adds =
{
  necromancy = {random(21) + 237, random(15) + 100, random(9) + 55, random(8) + 25, random(7) + 18, random(5) + 13, random(1) + 8}, -- доп войска некров
  haven = {[2] = random(8) + 92, [3] = random(12) + 48, [5] = random(5) + 27, [6] = random(2) + 13} -- доп войска людей
}

necro_army_add_dialog =
{
  path = m_path.."Duel/Army/Necro/",
  state = 1,
  icon = GetSpellIcon(200),
  title = "title",
  select_text = "",
  perform_func =
  function(player, curr_state, answer, next_state)
    local hero = Dialog.GetActiveHeroForPlayer(player)
    local return_state = 0
    if curr_state == 1 then
      if next_state ~= 2 then
        startThread(Hero.CreatureInfo.AddByTier, hero, TOWN_NECROMANCY, next_state - 100, army_adds.necromancy[next_state - 100])
      else
        return_state = 2
      end
    elseif curr_state == 2 then
      if next_state ~= 1 then
        startThread(Hero.CreatureInfo.AddByTier, hero, TOWN_NECROMANCY, next_state - 100, army_adds.necromancy[next_state - 100])
      else
        return_state = 1
      end
    end
    return return_state
  end,

  Open =
  function(player)
    Dialog.Action(player)
  end,

  options =
  {
   [1] =
   {
     [0] = m_path.."Duel/Army/Necro/info.txt",
     [1] = {"1.txt", 101, 1},
     [2] = {"2.txt", 102, 1},
     [3] = {"3.txt", 103, 1},
     [4] = {"4.txt", 104, 1},
     [5] = {"next.txt", 2, 1}
   },
   [2] =
   {
     [0] = m_path.."Duel/Army/Necro/info.txt",
     [1] = {"5.txt", 105, 1},
     [2] = {"6.txt", 106, 1},
     [3] = {"7.txt", 107, 1},
     [4] = {"back.txt", 1, 1}
   },
  }
}

human_army_add_dialog =
{
  path = m_path.."Duel/Army/Human/",
  state = 1,
  icon = "/UI/H5A1/Icons/Buildings/Adventures_Buildings/128x128/War_Academy.(Texture).xdb#xpointer(/Texture)",
  title = "title",
  select_text = "",
  perform_func =
  function(player, curr_state, answer, next_state)
    local hero = Dialog.GetActiveHeroForPlayer(player)
    if IsNum(next_state) then
      return 0
    end
    --
    local tier = next_state.tier
    local tier_to_remove = tier == 5 and 3 or tier - 1
    local count = next_state.num
    startThread(Hero.CreatureInfo.AddByTier, hero, TOWN_HEAVEN, tier, count)
    startThread(Hero.CreatureInfo.AddByTier, hero, TOWN_HEAVEN, tier_to_remove, -count)
    return 0
  end,

  Open =
  function(player)
    for i, option in Dialog.GetActiveDialogForPlayer(player).options do
      option = nil
    end
    Dialog.GetActiveDialogForPlayer(player).options[1] = {[0] = m_path.."Duel/Army/Human/info.txt"}
    --
    local hero = Dialog.GetActiveHeroForPlayer(player)
    local option_num = 0
    for i, tier in {1, 2, 3, 5} do
      local creature = TIER_TABLES[TOWN_HEAVEN][tier][1]
      local count = GetHeroCreatures(hero, creature)
      local needed_count = army_adds.haven[tier + (tier == 3 and 2 or 1)]
      -- доп трейнинг дл€ изабель
      if contains({"Isabell1", "Isabell2"}, hero) then
        needed_count = needed_count * 1.5
      end
      --
      if count ~= 0 then
        if needed_count > count then
          needed_count = count
        end
        option_num = option_num + 1
        Dialog.SetAnswer(Dialog.GetActiveDialogForPlayer(player), 1, option_num, {m_path.."Duel/Army/training.txt";
                                                                  name = Creature.Params.Name(creature), count = needed_count},
                                                                  {tier = tier + (tier == 3 and 2 or 1), num = needed_count}, 1, 1)
      end
    end
    Dialog.Action(player)
  end,

  options =
  {}
}