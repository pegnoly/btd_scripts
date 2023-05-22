CustomAbility.Hero = {}

CustomAbility.Hero.is_loaded = nil

CustomAbility.Hero.EnabledForHero = {}

CustomAbility.Hero.AbilitiesByHero = {}

CustomAbility.Hero.DialogPredefAnswers = {}

CustomAbility.Hero.Callbacks = {}

CustomAbility.Hero.MainDialog =
{
  state = 1,
  path = '/Text/CustomAbility/Main/',
  icon = '/Textures/Interface/Cartographer/Face_Texture.xdb#xpointer(/Texture)',
  title = 'hero_title',
  select_text = '',
  
  perform_func =
  function(player, curr_state, answer, next_state)
    startThread(CustomAbility.Hero.Callbacks[next_state], Dialog.GetActiveHeroForPlayer(player), player)
    return 0
  end,
  
  options = {},
  
  Reset =
  function(player)
    for i, option in Dialog.GetActiveDialogForPlayer(player).options do
      option = nil
    end
    Dialog.GetActiveDialogForPlayer(player).options[1] = {[0] = '/Text/CustomAbility/Main/hero_main.txt';}
  end,
  
  Open =
  function(player)
    Dialog.Reset(player)
    local n = 1
    for answer, info in CustomAbility.Hero.DialogPredefAnswers do
      if CustomAbility.Hero.AbilitiesByHero[Dialog.GetActiveHeroForPlayer(player)][answer] then
         Dialog.SetPredefAnswer(Dialog.GetActiveDialogForPlayer(player), 1, n, info)
         n = n + 1
      end
    end
    Dialog.Action(player)
  end
}

CustomAbility.Hero.is_loaded = 1