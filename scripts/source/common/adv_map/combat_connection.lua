CombatConnection = 
{
  combat_scripts_paths = {},

  CreateCombatFunctionsList =
  ---@meta 
  function(paths)
    local to_cmb = ""
    for i, path in paths do
      to_cmb = to_cmb..'["'..i..'"] = '..'"'..path..'", '
      --to_cmb = to_cmb.."'"..path.."', "
    end
    --consoleCmd("@SetGameVar('active_scripts', '"..to_cmb.."')")
    consoleCmd("@SetGameVar('active_scripts', 'return {to_cmb = {"..to_cmb.."},}')")
  end
}