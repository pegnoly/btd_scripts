seal_of_protection =
{
  active_for_hero = {},
  def_amount = 2
}

AddHeroEvent.AddListener("BTD_rmg_seal_of_protection_add_hero_event",
function(hero)
  seal_of_protection.active_for_hero[hero] = nil
  startThread(
  function()
    while 1 do
      if IsHeroAlive(%hero) then
        if not seal_of_protection.active_for_hero[%hero] then
          if HasHeroSkill(%hero, WIZARD_FEAT_SEAL_OF_PROTECTION) then
            seal_of_protection.active_for_hero[%hero] = 1
            Hero.Stats.Change(%hero, STAT_DEFENCE, seal_of_protection.def_amount)
          end
        else
          if not HasHeroSkill(%hero, WIZARD_FEAT_SEAL_OF_PROTECTION) then
            seal_of_protection.active_for_hero[%hero] = nil
            Hero.Stats.Change(%hero, STAT_DEFENCE, -seal_of_protection.def_amount)
          end
        end
      end
      sleep()
    end
  end)
end)