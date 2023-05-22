SPELL_SHOP_PATH = "Text/CustomAbility/SpellShop/"

spell_shop =
{
  -- здесь меняется цена за уровень спелла [уровень] = цена
  cost_by_tier = {[2] = 1750, [3] = 2000, [4] = 4250, [5] = 7000},

  used_by_player = {[PLAYER_1] = nil, [PLAYER_2] = nil},

  is_processed_by_player = {[PLAYER_1] = nil, [PLAYER_2] = nil},

  GiveRandomSpellByLevel =
  function(hero, spell_level)
    local spells = Hero.SpellInfo.GetLearnableSpellsByLevel(hero, spell_level)
    if len(spell) == 0 then
      startThread(MCCS_MessageBoxForPlayers, player, SPELL_SHOP_PATH.."nothing_to_learn.txt")
    else
      local gold = GetPlayerResource(player, GOLD)
      -- 22.08. Конфигурация цен после реворка логистики.
      local cost = economy.GetCostWithEconomy(hero, spell_shop.cost_by_tier[spell_level])
      local economed_gold = spell_shop.cost_by_tier[spell_level] - cost
      --
      if gold >= cost then
        SetPlayerResource(player, GOLD, gold - cost)
        -- 22.08. Экономия золота после реворка логистики.
        economy.EconomGold(hero, economed_gold)
        --
        local spell = Random.FromTable(spells)
        print("Bought spell ", spell)
        startThread(Hero.SpellInfo.TeachSpell, hero, spell)
        spell_shop.used_by_player[player] = 1
      else
        startThread(MCCS_MessageBoxForPlayers, player, SPELL_SHOP_PATH.."not_enough_gold.txt")
      end
    end
  end
}

spell_shop_dialog =
{
  state = 1,
  icon = "/UI/H5A2/Icons/Adv_Buildings/Spell_Shop.(Texture).xdb#xpointer(/Texture)",
  title = "title",
  select_text = "",
  path = "Text/CustomAbility/SpellShop/",
  perform_func =
  function(player, curr_state, answer, next_state)
    local hero = Dialog.GetActiveHeroForPlayer(player)
    if next_state ~= 0 then
      if pcall(spell_shop.GiveRandomSpellByLevel, hero, next_state) then
        spell_shop.is_processed_by_player[player] = nil
      end
    else
      spell_shop.is_processed_by_player[player] = nil
    end
    return 0
  end,

  options =
  {},

  Reset = function(player)
    for i, option in Dialog.GetActiveDialogForPlayer(player).options do
      option = nil
    end
  end,

  Open =
  function(player)
    Dialog.Reset(player)
    --
    Dialog.GetActiveDialogForPlayer(player).options[1] = {}
    Dialog.GetActiveDialogForPlayer(player).options[1] = {[0] = Dialog.GetActiveDialogForPlayer(player).path.."info.txt"}
    --
    local hero = Dialog.GetActiveHeroForPlayer(player)
    for option = 1, 4 do
      print('Spell shop: option ', option)
      Dialog.GetActiveDialogForPlayer(player).options[1][option] = nil
      local actual_option = option + 1
      -- 22.08. Конфигурация цен после реворка логистики.
      local cost = economy.GetCostWithEconomy(hero, spell_shop.cost_by_tier[actual_option])
      print('Cost: ', cost)
      --
      -- Dialog.GetActiveDialogForPlayer(player).options[option] = {}
      Dialog.SetAnswer(Dialog.GetActiveDialogForPlayer(player), 1, option, {"Text/CustomAbility/SpellShop/"..actual_option..".txt"; cost = cost}, actual_option, 1, 1)
    end
    print("Spell shop ok?")
    Dialog.Action(player)
  end,
}

MapLoadingEvent.AddListener("btd_init_spell_shop_event",
function()
  for i, shop in {"spell_shop_p1", "spell_shop_p2"} do
    Touch.DisableObject(shop)
    Touch.SetFunction(shop, "_spell_shop_touch",
    function(hero, object)
      local player = GetObjectOwner(hero)
      if not spell_shop.used_by_player[player] then
        if not spell_shop.is_processed_by_player[player] then
          spell_shop.is_processed_by_player[player] = 1
          startThread(Dialog.NewDialog, spell_shop_dialog, hero, player)
        end
      else
        startThread(MCCS_MessageBoxForPlayers, player, SPELL_SHOP_PATH.."already_used.txt")
      end
    end)
  end
end)