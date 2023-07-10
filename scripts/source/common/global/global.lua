TOWN_NECROPOLIS = TOWN_NECROMANCY
TOWN_NO_TYPE = -1

Global = 
{
  InitialDifficulty = GetDifficulty(),

  DefaultDifficulty = GetDifficulty() + 1,

  diff_coeffs = {0.55, 1, 1.3, 1.75},

  RACE_COLORS = 
  {
    [0] = '<color=FF285AFF>'; 
    '<color=FF20BF00>', 
    '<color=FFFE9300>', 
    '<color=FFC800FF>', 
    '<color=FF7DBFF1>', 
    '<color=FFFF1212>', 
    '<color=FFEF4B04>', 
    '<color=FFFFEC01>'
  }
}

function len(t)
  local answer = 0
  for k, v in t do
    if v then
      answer = answer + 1
    end
  end
  return answer
end

function keys(t)
  local answer, n = {}, 0
  for k, v in t do
	if v then
	  n = n + 1
	  answer[n] = k
	end
  end
  return answer
end

-- ���������� ����� ������� func
function pcall(func, ...)
  local ans = {[1] = -1}
  startThread(
  function()
    local ans = %ans
    errorHook(
    function()
      %ans[1] = 0
      print('<color=blue>This error makes no sense')
    end)
    ans[2] = %func(table.unpack(%arg))
    ans[1] = 1
  end)
  while ans[1] == -1 do sleep() end
  if ans[1] == 1 then
    return 1, ans[2]
  else
    return nil
  end
end

-- ����������� ������ � ���������, ������� ����� ������� MessageBox'�� � �.�(RedHeavenHero)
function rtext(message)
  local t = string.spread(message)
  local answer = {'Text/rawtext/message.txt'}
  for i = 1, length(t) - 1 do
    answer['l'.. i] = '/Text/rawtext/'..string.bytes[t[i]]..'.txt'
  end
  return answer
end

to_low =
{
  ['�'] = '�', ['�'] = '�', ['�'] = '�', ['�'] = '�', ['�'] = '�', ['�'] = '�', ['�'] = '�', ['�'] = '�', ['�'] = '�', ['�'] = '�', ['�'] = '�', ['�'] = '�',
  ['�'] = '�', ['�'] = '�', ['�'] = '�', ['�'] = '�', ['�'] = '�', ['�'] = '�', ['�'] = '�', ['�'] = '�', ['�'] = '�', ['�'] = '�', ['�'] = '�', ['�'] = '�',
  ['�'] = '�', ['�'] = '�', ['�'] = '�', ['�'] = '�', ['�'] = '�', ['�'] = '�', ['�'] = '�', ['�'] = '�', ['�'] = '�'
}

to_up =
{
  ['�'] = '�', ['�'] = '�', ['�'] = '�', ['�'] = '�', ['�'] = '�', ['�'] = '�', ['�'] = '�', ['�'] = '�', ['�'] = '�', ['�'] = '�', ['�'] = '�', ['�'] = '�',
  ['�'] = '�', ['�'] = '�', ['�'] = '�', ['�'] = '�', ['�'] = '�', ['�'] = '�', ['�'] = '�', ['�'] = '�', ['�'] = '�', ['�'] = '�', ['�'] = '�', ['�'] = '�',
  ['�'] = '�', ['�'] = '�', ['�'] = '�', ['�'] = '�', ['�'] = '�', ['�'] = '�', ['�'] = '�', ['�'] = '�', ['�'] = '�'
}

function Toupper(msg)
  local s = string.spread(msg)
  local new_text = ''
  for i = 1, length(s) - 1 do
    if to_up[s[i]] then
      new_text = new_text..to_up[s[i]]
    else
      new_text = new_text..s[i]
    end
  end
  return new_text
end

--
--------------------------------------------------------------------------------
--
function add(a, b)
  return a + b
end

function IsNum(x)
  if pcall(add, x, 0) then
    return 1
  else
    return nil
  end
end