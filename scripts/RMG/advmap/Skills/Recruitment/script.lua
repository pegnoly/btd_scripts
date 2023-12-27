-- @skill
recruitment_rmg =
{
    active_for_hero = {},
    levels_for_hero = {},
    grow_percent = 0.5
}

AddHeroEvent.AddListener("BTD_RMG_recruitment_add_hero",
function(hero)
    recruitment_rmg.levels_for_hero[hero] = {
        [10] = 1,
        [20] = 1,
        [30] = 1,
        [40] = 1
    }
    recruitment_rmg.active_for_hero[hero] = nil
    startThread(
    function()
        while 1 do
            if IsHeroAlive(%hero) then
                if not recruitment_rmg.active_for_hero[%hero] then
                    if HasHeroSkill(%hero, PERK_RECRUITMENT) then
                        recruitment_rmg.active_for_hero[%hero] = 1
                        RecruitmentRMG_GiveForPassedLevels(%hero)
                        sleep(20)
                        LevelUpEvent.AddListener("BTD_RMG_recruitment_level_up_"..%hero, RecruitmentRMG_LvlUp)
                    end
                else
                    if not HasHeroSkill(%hero, PERK_RECRUITMENT) then
                        recruitment_rmg.active_for_hero[%hero] = nil
                        LevelUpEvent.RemoveListener("BTD_RMG_recruitment_level_up_"..%hero)
                    end
                end
            end
            sleep()
        end
    end)
end)

function RecruitmentRMG_GiveGrow(hero)
    local race = Hero.Params.Town(hero)
    for i = 1, 3 do
        startThread(Hero.CreatureInfo.DefaultGrow, hero, race, i, ceil(Creature.Params.Grow(TIER_TABLES[race][i][1]) * recruitment_rmg.grow_percent))
    end
end

function RecruitmentRMG_GiveForPassedLevels(hero)
    local level = GetHeroLevel(hero)
    for lvl_stamp, not_given in recruitment_rmg.levels_for_hero[hero] do
        if lvl_stamp and not_given and level >= lvl_stamp then
            recruitment_rmg.levels_for_hero[hero][lvl_stamp] = nil
            startThread(RecruitmentRMG_GiveGrow, hero)
        end
    end
end

function RecruitmentRMG_LvlUp(hero)
    if HasHeroSkill(hero, PERK_RECRUITMENT) then
        local level = GetHeroLevel(hero)
        for lvl_stamp, not_given in recruitment_rmg.levels_for_hero[hero] do
            if lvl_stamp and not_given and lvl_stamp == level then
                recruitment_rmg.levels_for_hero[hero][lvl_stamp] = nil
                startThread(RecruitmentRMG_GiveGrow, hero)
            end
        end
    end
end