SKILL_SHOP_PATH = "Text/CustomAbility/SkillShop/"
-- магазин базовых навыков
skill_shop =
{
  skill_names =
  {
    [SKILL_LEADERSHIP] = SKILL_SHOP_PATH.."Leadership.txt",
    [SKILL_DEFENCE] = SKILL_SHOP_PATH.."Defence.txt",
    [SKILL_WAR_MACHINES] = SKILL_SHOP_PATH.."Machines.txt",
    [SKILL_OFFENCE] = SKILL_SHOP_PATH.."Offence.txt",
    [SKILL_LOGISTICS] = SKILL_SHOP_PATH.."Logistics.txt",
    [SKILL_LIGHT_MAGIC] = SKILL_SHOP_PATH.."Light.txt",
    [SKILL_LUCK] = SKILL_SHOP_PATH.."Luck.txt",
    [SKILL_DARK_MAGIC] = SKILL_SHOP_PATH.."Dark.txt",
    [SKILL_SORCERY] = SKILL_SHOP_PATH.."Sorsery.txt",
    [SKILL_DESTRUCTIVE_MAGIC] = SKILL_SHOP_PATH.."Chaos.txt",
    [SKILL_SUMMONING_MAGIC] = SKILL_SHOP_PATH.."Summon.txt",
    [SKILL_LEARNING] = SKILL_SHOP_PATH.."Learning.txt",
    [HERO_SKILL_BARBARIAN_LEARNING] = SKILL_SHOP_PATH.."Learning.txt",
    [HERO_SKILL_SHATTER_DESTRUCTIVE_MAGIC] = SKILL_SHOP_PATH.."ShatterChaos.txt",
    [HERO_SKILL_SHATTER_LIGHT_MAGIC] = SKILL_SHOP_PATH.."ShatterLight.txt",
    [HERO_SKILL_SHATTER_SUMMONING_MAGIC] = SKILL_SHOP_PATH.."ShatterSummon.txt",
    [HERO_SKILL_SHATTER_DARK_MAGIC] = SKILL_SHOP_PATH.."DarkShatter.txt",
    [HERO_SKILL_VOICE] = SKILL_SHOP_PATH.."Voice.txt",
  },

  skill_probs_by_class =
  {
    -- рыцарь
    [HERO_CLASS_KNIGHT] =
    {
      [SKILL_LEADERSHIP] = 15,
      [SKILL_DEFENCE] = 15,
      [SKILL_TRAINING] = 10,
      [SKILL_WAR_MACHINES] = 10,
      [SKILL_OFFENCE] = 10,
      [SKILL_LOGISTICS] = 8,
      [SKILL_LIGHT_MAGIC] = 8,
      [SKILL_LUCK] = 8,
      [SKILL_DARK_MAGIC] = 8,
    },
    -- рейнджер
    [HERO_CLASS_RANGER] =
    {
      [SKILL_LEADERSHIP] = 8,
      [SKILL_DEFENCE] = 10,
      [SKILL_AVENGER] = 10,
      [SKILL_OFFENCE] = 6,
      [SKILL_LOGISTICS] = 15,
      [SKILL_LIGHT_MAGIC] = 8,
      [SKILL_LUCK] = 15,
      [SKILL_SORCERY] = 8,
      [SKILL_DESTRUCTIVE_MAGIC] = 8,
      [SKILL_LEARNING] = 10
    },
    -- маг
    [HERO_CLASS_WIZARD] =
    {
      [SKILL_ARTIFICIER] = 10,
      [SKILL_WAR_MACHINES] = 8,
      [SKILL_LIGHT_MAGIC] = 8,
      [SKILL_LUCK] = 8,
      [SKILL_DARK_MAGIC] = 8,
      [SKILL_SORCERY] = 10,
      [SKILL_DESTRUCTIVE_MAGIC] = 8,
      [SKILL_SUMMONING_MAGIC] = 15,
      [SKILL_LEARNING] = 15
    },
    -- демон
    [HERO_CLASS_DEMON_LORD] =
    {
      [SKILL_DEFENCE] = 8,
      [SKILL_GATING] = 10,
      [SKILL_WAR_MACHINES] = 10,
      [SKILL_OFFENCE] = 15,
      [SKILL_LOGISTICS] = 15,
      [SKILL_LUCK] = 8,
      [SKILL_DARK_MAGIC] = 8,
      [SKILL_SORCERY] = 8,
      [SKILL_DESTRUCTIVE_MAGIC] = 10,
    },
    -- некромант
    [HERO_CLASS_NECROMANCER] =
    {
      [SKILL_DEFENCE] = 10,
      [SKILL_NECROMANCY] = 15,
      [SKILL_OFFENCE] = 8,
      [SKILL_LOGISTICS] = 8,
      [SKILL_DARK_MAGIC] = 15,
      [SKILL_SORCERY] = 10,
      [SKILL_DESTRUCTIVE_MAGIC] = 8,
      [SKILL_SUMMONING_MAGIC] = 10,
      [SKILL_LEARNING] = 8
    },
    -- чернокнижник
    [HERO_CLASS_WARLOCK] =
    {
      [SKILL_INVOCATION] = 10,
      [SKILL_WAR_MACHINES] = 8,
      [SKILL_OFFENCE] = 15,
      [SKILL_LOGISTICS] = 8,
      [SKILL_LUCK] = 8,
      [SKILL_SORCERY] = 10,
      [SKILL_DESTRUCTIVE_MAGIC] = 15,
      [SKILL_SUMMONING_MAGIC] = 10,
      [SKILL_LEARNING] = 8
    },
    -- гном
    [HERO_CLASS_RUNEMAGE] =
    {
      [SKILL_LEADERSHIP] = 8,
      [SKILL_DEFENCE] = 15,
      [HERO_SKILL_RUNELORE] = 10,
      [SKILL_WAR_MACHINES] = 15,
      [SKILL_OFFENCE] = 8,
      [SKILL_LIGHT_MAGIC] = 8,
      [SKILL_LUCK] = 8,
      [SKILL_DESTRUCTIVE_MAGIC] = 10,
      [SKILL_SUMMONING_MAGIC] = 4,
      [SKILL_LEARNING] = 8
    },
    -- орк
    [HERO_CLASS_BARBARIAN] =
    {
      [SKILL_LEADERSHIP] = 10,
      [SKILL_DEFENCE] = 10,
      [HERO_SKILL_DEMONIC_RAGE] = 10,
      [SKILL_WAR_MACHINES] = 8,
      [SKILL_OFFENCE] = 15,
      [SKILL_LOGISTICS] = 15,
      [SKILL_LUCK] = 8,
      [HERO_SKILL_SHATTER_DESTRUCTIVE_MAGIC] = 5,
      [HERO_SKILL_SHATTER_LIGHT_MAGIC] = 5,
      [HERO_SKILL_SHATTER_SUMMONING_MAGIC] = 5,
      [HERO_SKILL_SHATTER_DARK_MAGIC] = 5
    }
  },

  -- здесь меняются цены за % навыка [%] = цена
  skill_costs_by_rarity =
  {
    [15] = 3000,
    [10] = 4000,
    [8] = 4000,
    [6] = 5000,
    [5] = 5000,
    [4] = 6000,
  },

  used_by_player = {[PLAYER_1] = nil, [PLAYER_2] = nil}
}

skill_shop_dialog =
{
  path = "Text/CustomAbility/SkillShop/",
  state = 1,
  icon = "/UI/H5A1/Icons/Buildings/Adventures_Buildings/128x128/Library_of_Enlightenment.(Texture).xdb#xpointer(/Texture)",
  title = "title",
  select_text = "",

  perform_func =
  function(player, curr_state, answer, next_state)
    local return_state = 0
    if next_state < 100 then
      return next_state
    else
      local hero = Dialog.GetActiveHeroForPlayer(player)
      local skill = next_state - 100
      local class = GetHeroClass(hero)
      -- 22.08. Конфигурация цен после реворка логистики
      local cost = economy.GetCostWithEconomy(hero, skill_shop.skill_costs_by_rarity[skill_shop.skill_probs_by_class[class][skill]])
      local economed_gold = skill_shop.skill_costs_by_rarity[skill_shop.skill_probs_by_class[class][skill]] - cost
      --
      local gold = GetPlayerResource(player, GOLD)
      if gold >= cost then
        GiveHeroSkill(hero, skill)
        SetPlayerResource(player, GOLD, gold - cost)
        -- 22.08. Экономия золота после реворка логистики
        economy.EconomGold(hero, economed_gold)
        --
        skill_shop.used_by_player[player] = 1
      else
        startThread(MCCS_MessageBoxForPlayers, player, SKILL_SHOP_PATH.."not_enough_gold.txt")
      end
      return 0
    end
  end,

  options = {},

  Reset = function(player)
    for i, option in Dialog.GetActiveDialogForPlayer(player).options do
      option = nil
    end
  end,

  Open = function(player)
    Dialog.Reset(player)
    print("Dialog started?")
    while not skill_shop do
      sleep()
    end
    --
    local hero = Dialog.GetActiveHeroForPlayer(player)
    local class = Hero.Params.Class(hero)
    local current_state, current_option = 1, 1
    local current_skills_count = 0
    local new_state_initialized = nil
    for skill, _ in skill_shop.skill_probs_by_class[class] do
      print("Checking skill ", skill, " for hero ", hero, " with class ", class)
      --
      if current_option == 5 and new_state_initialized then
        current_state = current_state + 1
        Dialog.SetAnswer(Dialog.GetActiveDialogForPlayer(player), current_state - 1, current_option, DEFAULT_NEXT, current_state, 1, 1)
        current_option = 1
        new_state_initialized = nil
      end
      --
      if current_option == 1 and (not new_state_initialized) then
        Dialog.GetActiveDialogForPlayer(player).options[current_state] = {}
        Dialog.GetActiveDialogForPlayer(player).options[current_state] = {[0] = Dialog.GetActiveDialogForPlayer(player).path.."info.txt"}
        new_state_initialized = 1
        print("New state initialized")
      end
      --
      if GetHeroSkillMastery(hero, skill) == 0 then
        print("Can learn skill")
        local skill_name = skill_shop.skill_names[skill]
        print("Name: ", skill_name)
        -- 22.08. Конфигурация цен после реворка логистики.
        local skill_cost = economy.GetCostWithEconomy(hero, skill_shop.skill_costs_by_rarity[skill_shop.skill_probs_by_class[class][skill]])
        print("Cost: ", skill_cost)
        --
        Dialog.SetAnswer(Dialog.GetActiveDialogForPlayer(player), current_state, current_option, {SKILL_SHOP_PATH.."skill_name_cost.txt"; name = skill_name, cost = skill_cost}, skill + 100, 1, 1)
        current_option = current_option + 1
      else
        current_skills_count = current_skills_count + 1
      end
    end
    --
    if current_skills_count < 6 then
      Dialog.Action(player)
    else
      startThread(MCCS_MessageBoxForPlayers, player, SKILL_SHOP_PATH.."cant_learn_any_skill.txt")
    end
  end
}

MapLoadingEvent.AddListener("skill_shop_init_event",
function()
  for i, shop in {"skill_shop_p1", "skill_shop_p2"} do
    Touch.DisableObject(shop)
    Touch.SetFunction(shop, "_skill_shop_touch",
    function(hero, object)
      local player = GetObjectOwner(hero)
      if not skill_shop.used_by_player[player] then
        startThread(Dialog.NewDialog, skill_shop_dialog, hero, GetObjectOwner(hero))
      else
        startThread(MCCS_MessageBoxForPlayers, player, SKILL_SHOP_PATH.."already_used.txt")
      end
    end)
  end
end)