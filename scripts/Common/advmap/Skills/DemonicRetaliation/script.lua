--- 26.05.2023. Moved from rmg to common.

demonic_retaliation =
{
    active_for_hero = {},
    sp_amount = 3
}

AddHeroEvent.AddListener("BTD_rmg_demonic_retaliation_add_hero_event",
function(hero)
    demonic_retaliation.active_for_hero[hero] = nil
    startThread(
    function()
        while 1 do
          if IsHeroAlive(%hero) then
              if not demonic_retaliation.active_for_hero[%hero] then
                  if HasHeroSkill(%hero, DEMON_FEAT_DEMONIC_RETALIATION) then
                      demonic_retaliation.active_for_hero[%hero] = 1
                      Hero.Stats.Change(%hero, STAT_SPELL_POWER, demonic_retaliation.sp_amount)
                  end
              else
                  if not HasHeroSkill(%hero, DEMON_FEAT_DEMONIC_RETALIATION) then
                      demonic_retaliation.active_for_hero[%hero] = nil
                      Hero.Stats.Change(%hero, STAT_SPELL_POWER, -demonic_retaliation.sp_amount)
                  end
              end
          end
          sleep()
        end
    end)
end)