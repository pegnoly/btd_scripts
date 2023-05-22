wisdom =
{
  active_for_hero = {},
  know_amount = 1
}

AddHeroEvent.AddListener("BTD_rmg_wisdom_add_hero_event",
function(hero)
  wisdom.active_for_hero[hero] = nil
  startThread(
  function()
    while 1 do
      if IsHeroAlive(%hero) then
        if not wisdom.active_for_hero[%hero] then
          if HasHeroSkill(%hero, PERK_WISDOM) then
            wisdom.active_for_hero[%hero] = 1
            Hero.Stats.Change(%hero, STAT_KNOWLEDGE, wisdom.know_amount)
          end
        else
          if not HasHeroSkill(%hero, PERK_WISDOM) then
            wisdom.active_for_hero[%hero] = nil
            Hero.Stats.Change(%hero, STAT_KNOWLEDGE, -wisdom.know_amount)
          end
        end
      end
      sleep()
    end
  end)
end)