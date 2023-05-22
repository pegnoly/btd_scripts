lord_of_undead =
{
  active_for_hero = {},
  sp_amount = 2,
  kn_amount = 1,
}

AddHeroEvent.AddListener("BTD_rmg_lord_of_undead_add_hero_event",
function(hero)
  lord_of_undead.active_for_hero[hero] = nil
  startThread(
  function()
    while 1 do
      if IsHeroAlive(%hero) then
        if not lord_of_undead.active_for_hero[%hero] then
          if HasHeroSkill(%hero, NECROMANCER_FEAT_LORD_OF_UNDEAD) then
            lord_of_undead.active_for_hero[%hero] = 1
            Hero.Stats.Change(%hero, STAT_SPELLPOWER, lord_of_undead.sp_amount)
            Hero.Stats.Change(%hero, STAT_KNOWLEDGE, lord_of_undead.kn_amount)
          end
        else
          if not HasHeroSkill(%hero, NECROMANCER_FEAT_LORD_OF_UNDEAD) then
            lord_of_undead.active_for_hero[%hero] = nil
            Hero.Stats.Change(%hero, STAT_SPELLPOWER, -lord_of_undead.sp_amount)
            Hero.Stats.Change(%hero, STAT_KNOWLEDGE, -lord_of_undead.kn_amount)
          end
        end
      end
      sleep()
    end
  end)
end)