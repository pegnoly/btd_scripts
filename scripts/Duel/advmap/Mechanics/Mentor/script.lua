--
--------------------------------------------------------------------------------
-- ������
mentor =
{
  cost = 6500, -- ���� ������������ �������
  path = GetMapDataPath().."Mentor/",

  used_by_hero = {},

  saved_removal_info = {},

  Init = function()
    for i, hero in GetObjectNamesByType('HERO') do
      LockMinHeroSkillsAndAttributes(hero)
      -- test
      --AddHeroCreatures(hero, CREATURE_PHOENIX, 1000)
    end
    --
    for i, object in {"mentor_new_1", "mentor_new_2",} do
      print("<color=yellow>Enabled mentor!\n")
      SetObjectEnabled(object, nil)
      Trigger(OBJECT_TOUCH_TRIGGER, object, 'mentor.Touch')
    end
  end,

  IsValidForUsage = function(player, hero)
    local res_to_remove = {}
    local art_to_remove = {}
    for res = WOOD, GOLD do
      res_to_remove[res] = 0
    end
    -- ����� � ����
    if HasHeroSkill(hero, PERK_FORTUNATE_ADVENTURER) then
      for res = WOOD, GEM do
        res_to_remove[res] = res_to_remove[res] + 3
      end

      local art = path_luck.art_for_hero[hero]
      if HasArtefact(hero, art) then
        art_to_remove[length(art_to_remove)+1] = art
      else
        res_to_remove[GOLD] = res_to_remove[GOLD] + ceil(GetArtCost(art) / 2)
      end
    end
    -- �����������
    if HasHeroSkill(hero, HERO_SKILL_SNATCH) then
      res_to_remove[GOLD] = res_to_remove[GOLD] + 10000
    end
    -- ������
    if HasHeroSkill(hero, WIZARD_FEAT_SPOILS_OF_WAR) then
      local art = spoils_of_war.art_for_hero[hero]
      if HasArtefact(hero, art) then
        art_to_remove[length(art_to_remove)+1] = art
      else
        res_to_remove[GOLD] = res_to_remove[GOLD] + ceil(GetArtCost(art) / 2)
      end
    end
    -- ���������� ������
    if HasHeroSkill(hero, PERK_ESTATES) then
      res_to_remove[GOLD] = res_to_remove[GOLD] + 3750
    end
    -- ���������
    print('Hero economed ', economy.gold_economed_by_hero[hero], ' with logistics')
    res_to_remove[GOLD] = res_to_remove[GOLD] + economy.gold_economed_by_hero[hero]
    --
    local res_to_remove_with_mentor_cost = {}
    table.copy(res_to_remove, res_to_remove_with_mentor_cost)
    res_to_remove_with_mentor_cost[GOLD] = res_to_remove_with_mentor_cost[GOLD] + 10000
    --
    if Resource.IsEnoughT(player, res_to_remove_with_mentor_cost) then
      mentor.saved_removal_info[hero] = {res = res_to_remove, arts = art_to_remove}
      return 1
    else
      return nil
    end
  end,

  RemoveResources = function(player, hero)
    print("Removal info: ", mentor.saved_removal_info[hero])

    for _, artId in mentor.saved_removal_info[hero].arts do
      RemoveArtefact(hero, artId)
    end;
    --
    Resource.RemoveT(player, mentor.saved_removal_info[hero].res)
    --
    economy.gold_economed_by_hero[hero] = 0
    mentor.saved_removal_info[hero] = {}
  end,

  CalculateActualXpToReturn =
  function(player, hero, xp)
    local current_level = GetHeroLevel(hero)
    --
    if HasHeroSkill(hero, HERO_SKILL_MENTORING) then
      current_level = current_level - 1
    end
    --
    if HasHeroSkill(hero, WARLOCK_FEAT_DARK_REVELATION) then
      current_level = current_level - 1
    end
    --
    local xp_to_return = LEVELS[current_level]
    return xp_to_return
  end,

  Touch = function(hero, object)
    local player = GetObjectOwner(hero)
    if not mentor.used_by_hero[hero] then
      --
      if mentor.IsValidForUsage(player, hero) then
        if MCCS_QuestionBoxForPlayers(player, {mentor.path.."info.txt"; cost = mentor.cost}) then
          local gold = GetPlayerResource(player, GOLD)
          if gold >= mentor.cost then
            SetPlayerResource(player, GOLD, gold - mentor.cost)
            local xp = GetHeroStat(hero, STAT_EXPERIENCE)
            local xp_to_return = mentor.CalculateActualXpToReturn(player, hero, xp)
            TakeAwayHeroExp(hero, xp)
            startThread(mentor.RemoveResources, player, hero)
            mentor.used_by_hero[hero] = xp_to_return
          else
            startThread(MCCS_MessageBoxForPlayers, player, mentor.path.."not_enough_gold.txt")
          end
        end
      else
        startThread(MCCS_MessageBoxForPlayers, player, mentor.path.."cant_use.txt")
      end
    else
      if MCCS_QuestionBoxForPlayers(player, mentor.path.."info_used.txt") then
       GiveExp(hero, mentor.used_by_hero[hero])
       mentor.used_by_hero[hero] = nil
      end
    end
  end
}

MapLoadingEvent.AddListener("btd_mentor_init_event",
function()
  startThread(mentor.Init)
end)