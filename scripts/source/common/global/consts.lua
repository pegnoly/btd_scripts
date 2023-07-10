TOWN_NO_TYPE = -1
TOWN_HEAVEN = 0
TOWN_PRESERVE = 1
TOWN_ACADEMY = 2
TOWN_DUNGEON = 3
TOWN_NECROMANCY = 4
TOWN_INFERNO = 5
TOWN_FORTRESS = 6
TOWN_STRONGHOLD = 7

TOWN_NECROPOLIS = TOWN_NECROMANCY

initialDifficulty = GetDifficulty()

defaultDifficulty = GetDifficulty() + 1

diffCoeffs = {0.55, 1, 1.3, 1.75}

RACE_COLORS = 
{
	[0] = "/Text/Default/RaceColors/Heaven.txt";
	"/Text/Default/RaceColors/Preserve.txt",
	"/Text/Default/RaceColors/Academy.txt",
	"/Text/Default/RaceColors/Dungeon.txt",
	"/Text/Default/RaceColors/Necropolis.txt",
	"/Text/Default/RaceColors/Inferno.txt",
	"/Text/Default/RaceColors/Fortress.txt",
  "/Text/Default/RaceColors/Stronghold.txt"
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
	  answer[n] = k
	  n = n + 1
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