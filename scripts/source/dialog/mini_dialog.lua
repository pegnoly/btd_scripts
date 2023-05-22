SPEAKER_TYPE_HERO = 1
SPEAKER_TYPE_CREATURE = 2

MiniDialog = {}
MiniDialog.Sets = {}
MiniDialog.answer_for_player = {[PLAYER_1] = 6, [PLAYER_2] = 6, [PLAYER_3] = 6, [PLAYER_4] = 6, [PLAYER_5] = 6, [PLAYER_6] = 6, [PLAYER_7] = 6, [PLAYER_8] = 6}

MiniDialog.Start =
function(path, player, name, alt_set)
  if not MiniDialog.Sets[name] then
    doFile(path.."script.lua")
    while not MiniDialog.Sets[name] do
      sleep()
    end
  end
  --
  local steps_count = 0
  for step, info in MiniDialog.Sets[name] do
    local step_spreaded = string.spread(step)
    if not contains(step_spreaded, '_') then
      steps_count = steps_count + 1
    end
  end
  --
  MiniDialog.Step(path, player, MiniDialog.Sets[name], 1, steps_count, alt_set)
end

MiniDialog.Step =
function(path, player, set, curr_step, max_step, alt_set)
  local answers = {rtext('�����'), rtext('�����')}
  MiniDialog.answer_for_player[player] = 6
  if curr_step == 1 then
    answers[2] = nil
  elseif curr_step == max_step then
    answers = {rtext('���������'), rtext('�����')}
  end
  -- ����������� ����������� ���� ������� � ������ ������� ��������������� ������
  local saved_state = curr_step
  if alt_set and set[curr_step.."_"..alt_set] then
    --print(curr_step.."_"..alt_set)
    --print(char_set[curr_step.."_"..alt_set])
    curr_step = curr_step.."_"..alt_set
    --print('ok?')
  else
    curr_step = ""..curr_step
  end
  local text = path..curr_step..".txt"
  print('<color=red>MiniDialog: <color=green>curr state is ', curr_step)
  print('<color=red>MiniDialog: <color=green>curr text is ', text)
  -- ��������� ������
  local icon = ""
  if set[curr_step].type == SPEAKER_TYPE_HERO then
    icon = Hero.Params.Icon(set[curr_step].speaker)
  else
    icon = Creature.Params.Icon(set[curr_step].speaker)
  end
  if string.spread(icon)[1] ~= '/' then
    icon = '/'..icon
  end
  print('<color=red>MiniDialog: <color=green>curr icon is ', icon)
  --print(curr_state, ': ok here???')
  -- ������ �������
  TalkBoxForPlayers(player, icon, nil,
                 text, nil,
                 'MiniDialog.Callback', 1,
                 nil,
                 0, 0,
                 answers[1],
                 answers[2],
                 nil,
                 nil,
                 nil)
  -- ���� ����� ������
  while MiniDialog.answer_for_player[player] == 6 do
    sleep()
  end
  local ans = MiniDialog.answer_for_player[player]
  if ans < 1 then
    return
  else
    if ans == 1 then
      if saved_state == max_step then
        return
      else
        saved_state = saved_state + 1
      end
    else
      saved_state = saved_state - 1
    end
  end
  MiniDialog.Step(path, player, set, saved_state, max_step, alt_set)
end

MiniDialog.Callback =
function(player, answer)
  MiniDialog.answer_for_player[player] = answer
end