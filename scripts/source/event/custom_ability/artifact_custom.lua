CustomAbility.Artifact = {}

CustomAbility.Artifact.is_loaded = nil

CustomAbility.Artifact.EnabledForHero = {}

CustomAbility.Artifact.AbilitiesByHero = {}

CustomAbility.Artifact.DialogPredefAnswers = {}

CustomAbility.Artifact.Callbacks = {}

CustomAbility.Artifact.MainDialog =
{
  state = 1,
  path = '/Text/CustomAbility/Artifacts/',
  icon = '/Textures/Interface/Cartographer/Face_Texture.xdb#xpointer(/Texture)',
  title = 'art_title',
  select_text = 'art_select',

  -- исполн€ема€ функци€ берет функцию из таблицы art_custom_callbacks, котора€ соответствует активированной абилке и исполн€ет ее, передава€ геро€, активировавшего диалог и игрока, которому он принадлежит
  perform_func =
  function(player, curr_state, answer, next_state)
    startThread(CustomAbility.Artifact.Callbacks[next_state], Dialog.GetActiveHeroForPlayer(player), player)
    return 0
  end,

  options = {},

  Reset =
  function(player)
    for i, option in Dialog.GetActiveDialogForPlayer(player).options do
      option = nil
    end
    Dialog.GetActiveDialogForPlayer(player).options[1] = {[0] = 'art_choise.txt';}
  end,

  Open =
  function(player)
    Dialog.Reset(player)
    local n = 1
    for answer, info in CustomAbility.Artifact.DialogPredefAnswers do
      if CustomAbility.Artifact.AbilitiesByHero[Dialog.GetActiveHeroForPlayer(player)][answer] then
         Dialog.SetPredefAnswer(Dialog.GetActiveDialogForPlayer(player), 1, n, info)
         n = n + 1
      end
    end
    Dialog.Action(player)
  end
}

CustomAbility.Artifact.is_loaded = 1

--art_choise_dialog =
--{
--  state = 1,
--  path = ART_CUSTOM_PATH,
--  icon = '/Textures/Interface/Cartographer/Face_Texture.xdb#xpointer(/Texture)',
--  title = 'up_arts_title',
--  select_text = '',
--
--  perform_func =
--  function(player, curr_state, answer, next_state)
--    print('Give art to player ', player, ' hero - ', Dialog.GetActiveHeroForPlayer(player))
--    if next_state == 1 then
--      GiveArtifact(Dialog.GetActiveHeroForPlayer(player), ARTIFACT_SOULBINDER_L1)
--    elseif next_state == 2 then
--      GiveArtifact(Dialog.GetActiveHeroForPlayer(player), ARTIFACT_SU_SCEPTER_L1)
--    elseif next_state == 3 then
--      GiveArtifact(Dialog.GetActiveHeroForPlayer(player), ARTIFACT_OTHERSIDE_VEIL_L1)
--    end
--    return 0
--  end,
--
--  options =
--  {
--    [1] = {[0] = ART_CUSTOM_PATH..'up_art_choise.txt'; {ART_CUSTOM_PATH..'choose_soulbinder.txt', 1, 1}, {ART_CUSTOM_PATH..'choose_scepter.txt', 2, 1}, {ART_CUSTOM_PATH..'choose_veil.txt', 3, 1}}
--  },
--
--  Open = function(player)
--    Dialog.Action(player)
--  end
--}