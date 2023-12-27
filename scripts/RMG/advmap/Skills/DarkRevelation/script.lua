dark_revelation_rmg =
{
    active_for_hero = {},
    exp_per_divisor = 2500,
    lvl_divisor = 5
}

AddHeroEvent.AddListener("BTD_RMG_dark_revelation_add_hero",
function(hero)
    dark_revelation_rmg.active_for_hero[hero] = nil
    startThread(
    function()
        while 1 do
            if IsHeroAlive(%hero) then
                if not dark_revelation_rmg.active_for_hero[%hero] then 
                    if HasHeroSkill(%hero, WARLOCK_FEAT_DARK_REVELATION) then
                        dark_revelation_rmg.active_for_hero[%hero] = 1
                        local exp_to_give = (1 + floor(GetHeroLevel(%hero) / dark_revelation_rmg.lvl_divisor)) * dark_revelation_rmg.exp_per_divisor
                        Hero.Stats.Change(%hero, STAT_EXPERIENCE, exp_to_give)
                        return
                    end
                end
            end
            sleep()
        end
    end)
end)