--------------------------------------------------------------------------------
-- ������� ������. ���������� ������� ��� � ��������� ������ ������� �������� ��.
-- ������� ����������� �������, � ��� �� ���� � ��������� ������ ������� ��������������
-- �� ����� ��� ������� �� RedHeavenHero, �� ��� ��� �������� �������������
--consoleCmd('game_writelog 1')
-- ����� ���(��� ������) 0.4.0
--do
--  local fight_number = -1
--  if GetGameVar("MCCS_FightNumber") == '' then
--    fight_number = 1
--    SetGameVar("MCCS_FightNumber", 1)
--  else
--    fight_number = ceil(GetGameVar("MCCS_FightNumber") + 0) + 1
--    SetGameVar("MCCS_FightNumber", fight_number)
--  end
--  local attacker = GetHeroName(GetAttackerHero())
--  local defender = GetDefenderHero() and GetHeroName(GetDefenderHero()) or "neutrals"
--  print("##Combat mode started##")
--  print("Fight �", fight_number, ' started between ', attacker, ' and ', defender)
--end

doFile('/scripts/source/init/combat_init.lua')
while not Creature do
	sleep()
end
--doFile('/scripts/lib/mccs_default_settings.lua')

Creature.Sorting.Init()

ATB_FILTER = 64679235
GetCreatureAtb = function(unit) return GetCreatureCount(unit, ATB_FILTER)
end

casters_checked = -1
--
--------------------------------------------------------------------------------
-- ����������� ������ ����(���� ��������� ��� ����)

if GetGameVar('MCCS_IsHotseat') == 'true' then
  print('<color=yellow>Game mode: <color=green>single or hotseat')
  local curr_owner = GetGameVar(GetHeroName(GetAttackerHero())..'_owner')
  if GetGameVar('combat_active_thread') ~= curr_owner then
    SetGameVar('combat_active_thread', curr_owner)
  end
  print('curr script owner changed to ', curr_owner)
  consoleCmd("@SetGameVar('"..curr_owner.."_combat_mode', 'real')")
  if GetDefenderHero() then
    local def_owner = GetGameVar(GetHeroName(GetDefenderHero())..'_owner')
    consoleCmd("@SetGameVar('"..def_owner.."_combat_mode', 'real')")
  end
-- LAN
else
   print('<color=yellow>Game mode: <color=green>LAN')
   if GetGameVar(GetHeroName(GetAttackerHero())..'_owner') == '1' and
    GetGameVar('combat_active_thread') == '' then
    SetGameVar('combat_active_thread', '1')
    --consoleCmd("@SetGameVar('combat_active_thread', '1')")
    print('<color=yellow>LAN: <color=green>player 1 calibrated')
  end
  --
  if GetGameVar(GetHeroName(GetAttackerHero())..'_owner') == '2' and
    GetGameVar('combat_active_thread') == '' then
    SetGameVar('combat_active_thread', '2')
    --consoleCmd("@SetGameVar('combat_active_thread', '2')")
    print('<color=yellow>LAN: <color=green>player 2 calibrated')
  end
  --
  if GetGameVar(GetHeroName(GetAttackerHero())..'_owner') == '3' and
    GetGameVar('combat_active_thread') == '' then
    SetGameVar('combat_active_thread', '3')
    --consoleCmd("@SetGameVar('combat_active_thread', '3')")
    print('<color=yellow>LAN: <color=green>player 3 calibrated')
  end
  --
  if GetGameVar(GetHeroName(GetAttackerHero())..'_owner') == '4' and
    GetGameVar('combat_active_thread') == '' then
    SetGameVar('combat_active_thread', '4')
    --consoleCmd("@SetGameVar('combat_active_thread', '4')")
    print('<color=yellow>LAN: <color=green>player 4 calibrated')
  end
  --
  if GetGameVar(GetHeroName(GetAttackerHero())..'_owner') == '5' and
    GetGameVar('combat_active_thread') == '' then
    SetGameVar('combat_active_thread', '5')
    --consoleCmd("@SetGameVar('combat_active_thread', '5')")
    print('<color=yellow>LAN: <color=green>player 5 calibrated')
  end
  --
  if GetGameVar(GetHeroName(GetAttackerHero())..'_owner') == '6' and
    GetGameVar('combat_active_thread') == '' then
    SetGameVar('combat_active_thread', '6')
    --consoleCmd("@SetGameVar('combat_active_thread', '6')")
    print('<color=yellow>LAN: <color=green>player 6 calibrated')
  end
  --
  if GetGameVar(GetHeroName(GetAttackerHero())..'_owner') == '7' and
    GetGameVar('combat_active_thread') == '' then
    SetGameVar('combat_active_thread', '7')
    --consoleCmd("@SetGameVar('combat_active_thread', '7')")
    print('<color=yellow>LAN: <color=green>player 7 calibrated')
  end
  --
  if GetGameVar(GetHeroName(GetAttackerHero())..'_owner') == '8' and
    GetGameVar('combat_active_thread') == '' then
    SetGameVar('combat_active_thread', '8')
    --consoleCmd("@SetGameVar('combat_active_thread', '8')")
    print('<color=yellow>LAN: <color=green>player 8 calibrated')
  end
end

--
--------------------------------------------------------------------------------
-- ������� �����

attacker_army = {} -- ������� �����������(������������ ���������� ����������)
attacker_real_army = {} -- �������� �����������(����������� ������ ��������� �����)
attacker_army_copies = {} -- ������� ����� ����� �����������(�����, ���� ����������� ��������� ����������� ������� �������, � ���� �� ��� ����� ���-�� ���)
                        -- ���� ����� ������������� ��������, ������ ������� ����� ����� � �������� ��
defender_army = {} -- ����������� ��� ������� ������
defender_real_army = {}
defender_army_copies = {}

--reserved_turn = 0 -- ����, ��� ����� �������� ���(� ������, ����� ��������� ���� ���-�� �������,
                  -- � ����� ������ ������� ���-�� ��� �� �������, UNIT_MOVE ����������� ����� � ��� ����� �������� � ���������)
                  
                  
-- ������
combat_event_add_creature = {}
combat_event_turn_end = {}

function AddCombatEvent(event_table, desc, func)
  event_table[desc] = func
end
--
--------------------------------------------------------------------------------

print((GetGameVar('active_scripts')))
paths = parse(GetGameVar('active_scripts'))()

-- �������� ������� ��� ���������� ���� �������� ��� ��������
function GetCombatFunctions()
  local thread = GetGameVar('combat_active_thread')
  consoleCmd("@SetGameVar('"..thread.."_combat_mode', 'real')")
  print ('<color=yellow>Combat thread: <color=green>active thread is: ', thread)
  if thread ~= GetGameVar(GetHeroName(GetAttackerHero())..'_owner') then
    print('<color=yellow>Combat thread: <color=green>another script thread is active so skip this')
    return
  end
  print("<color=yellow>Combat thread: <color=green>combat thread is same with attacker's owner, so this thread will be executed")
  --
  AddCombatFunction(CombatFunctions.START, "init_combat",
  function()
    InitRandom()
    while not random do
      sleep()
    end
   	-- for i, unit in GetCreatures(ATTACKER) do
      -- attacker_army[unit] = GetCreatureNumber(unit)
    -- end
    -- table.copy(attacker_army, attacker_real_army)
    -- for i, unit in GetCreatures(DEFENDER) do
      -- defender_army[unit] = GetCreatureNumber(unit)
    -- end
    -- table.copy(defender_army, defender_real_army)
    -- startThread(NewCreaturesAddToTablesThread)
    --
    -- for side = ATTACKER, DEFENDER do
    --   for i, creature in GetCreatures(side) do
    --     local abils_info = GetCreatureActiveAbilsInfo(creature)
    --     --print('abils_info: ', abils_info)
    --     if abils_info == HAS_BY_DEFAULT and GetUnitMaxManaPoints(creature) == 0 then
    --       SetUnitManaPoints(creature, 1)
    --     end
    --   end
    -- end
    --
    for i, creature in GetAttackerCreatures() do
      print(creature, " has position ", GetCreatureNumber(creature, 64679235))
    end
    --
  end)
  -- AddCombatFunction(CombatFunctions.UNIT_MOVE, "check_units",
  -- function()
	-- if casters_checked == -1 then
	-- 	casters_checked = 0
	-- 	CombatFunctions.UNIT_MOVE["check_units"] = nil
	-- 	for i, creature in GetAttackerCreatures() do
	-- 		if not attacker_real_army[creature] and not defender_real_army[creature] then
	-- 			pcall(removeUnit, creature)
	-- 		end
	-- 	end
	-- 	for i, creature in GetDefenderCreatures() do
	-- 		if not attacker_real_army[creature] and not defender_real_army[creature] then
	-- 			pcall(removeUnit, creature)
	-- 		end
	-- 	end
	-- end
  -- end)
  --
  if paths then
    for i, path in paths.to_cmb do
      doFile(path)
    end
  end
  --
end

-- ��������� ������� � �������, �������������� ������� �������
function AddCombatFunction(event_table, desc, func)
	event_table[desc] = func
end

-- ��������������� �������� ������� �� �������
function CallCombatFunctions(event_table, param, temp)
  local already_called_functions = {}
  local x
  for desc, func in event_table do
    if func then
		if not already_called_functions[desc] then
		   already_called_functions[desc] = 1
		end
		print("Calling ", desc)
		x = func(param) or temp
	end
  end
  return x
end

-- ������� ��� ������� �������
CombatFunctions =
{
  PREPARE = {},

	START = {},

	UNIT_MOVE = {},

	ATTACKER_UNIT_MOVE = {},
	ATTACKER_HERO_MOVE = {},
	ATTACKER_CREATURE_MOVE = {},
	ATTACKER_WARMACHINE_MOVE = {},
	ATTACKER_BUILDING_MOVE = {},

  DEFENDER_UNIT_MOVE = {},
	DEFENDER_HERO_MOVE = {},
	DEFENDER_CREATURE_MOVE = {},
	DEFENDER_WARMACHINE_MOVE = {},
	DEFENDER_BUILDING_MOVE = {},

	UNIT_DEATH = {},

  ATTACKER_UNIT_DEATH = {},
	ATTACKER_CREATURE_DEATH = {},
	ATTACKER_WARMACHINE_DEATH = {},
	ATTACKER_BUILDING_DEATH = {},

	DEFENDER_UNIT_DEATH = {},
	DEFENDER_CREATURE_DEATH = {},
	DEFENDER_WARMACHINE_DEATH = {},
	DEFENDER_BUILDING_DEATH = {},
}

-- ������� �������
function Prepare()
	CallCombatFunctions(CombatFunctions.PREPARE)
end

function Start()
    combatSetPause(1)
   	for i, unit in GetCreatures(ATTACKER) do
      attacker_army[unit] = GetCreatureNumber(unit)
    end
    table.copy(attacker_army, attacker_real_army)
    for i, unit in GetCreatures(DEFENDER) do
      defender_army[unit] = GetCreatureNumber(unit)
    end
    table.copy(defender_army, defender_real_army)
    startThread(NewCreaturesAddToTablesThread)
	while len(defender_real_army) == 0 do
		sleep()
	end
	startThread(CallCombatFunctions, CombatFunctions.START)
	sleep(44)
	combatSetPause(nil)
end

function UnitMove(unit)
  local res = CallCombatFunctions(CombatFunctions.UNIT_MOVE, unit)
  if IsAttacker(unit) then
    res = CallCombatFunctions(CombatFunctions.ATTACKER_UNIT_MOVE, unit, res)
    if IsHero(unit) then
      res = CallCombatFunctions(CombatFunctions.ATTACKER_HERO_MOVE, unit, res)
    elseif IsCreature(unit) then
      res = CallCombatFunctions(CombatFunctions.ATTACKER_CREATURE_MOVE, unit, res)
    elseif IsWarMachine(unit) then
      res = CallCombatFunctions(CombatFunctions.ATTACKER_WARMACHINE_MOVE, unit, res)
    elseif IsBuilding(unit) then
      res = CallCombatFunctions(CombatFunctions.ATTACKER_BUILDING_MOVE, unit, res)
    end
  elseif IsDefender(unit) then
    res = CallCombatFunctions(CombatFunctions.DEFENDER_UNIT_MOVE, unit, res)
    if IsHero(unit) then
      res = CallCombatFunctions(CombatFunctions.DEFENDER_HERO_MOVE, unit, res)
    elseif IsCreature(unit) then
      res = CallCombatFunctions(CombatFunctions.DEFENDER_CREATURE_MOVE, unit, res)
    elseif IsWarMachine(unit) then
      res = CallCombatFunctions(CombatFunctions.DEFENDER_WARMACHINE_MOVE, unit, res)
    elseif IsBuilding(unit) then
      res = CallCombatFunctions(CombatFunctions.DEFENDER_BUILDING_MOVE, unit, res)
    end
  end
  return res
end

function UnitDeath(unit)
  CallCombatFunctions(CombatFunctions.UNIT_DEATH, unit)
  if IsAttacker(unit) then
    CallCombatFunctions(CombatFunctions.ATTACKER_UNIT_DEATH, unit)
    if IsCreature(unit) then
      CallCombatFunctions(CombatFunctions.ATTACKER_CREATURE_DEATH, unit)
    elseif IsWarMachine(unit) then
      CallCombatFunctions(CombatFunctions.ATTACKER_WARMACHINE_DEATH, unit)
    elseif IsBuilding(unit) then
      CallCombatFunctions(CombatFunctions.ATTACKER_BUILDING_DEATH, unit)
    end
  elseif IsDefender(unit) then
    CallCombatFunctions(CombatFunctions.DEFENDER_UNIT_DEATH, unit)
    if IsCreature(unit) then
      CallCombatFunctions(CombatFunctions.DEFENDER_CREATURE_DEATH, unit)
    elseif IsWarMachine(unit) then
      CallCombatFunctions(CombatFunctions.DEFENDER_WARMACHINE_DEATH, unit)
    elseif IsBuilding(unit) then
      CallCombatFunctions(CombatFunctions.DEFENDER_BUILDING_DEATH, unit)
    end
  end
end

startThread(GetCombatFunctions)
--AddCombatFunction(CombatFunctions.UNIT_MOVE,
--function(unit)
--  if reserved_turn == 1 then
--    print('turn skipped...')
--    reserved_turn = 0
--  end
--end)