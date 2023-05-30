-- @skill
-- ���� �����
recruitment =
{
  active_for_hero = {},
  grow_percent = 0.5
}

LevelUpEvent.AddListener("BTD_RMG_recruitment_level_up",
function(hero)
    if mod(GetHeroLevel(hero), 10) == 0 and HasHeroSkill(hero, PERK_RECRUITMENT) then
        local race = Hero.Params.Town(hero)
        for i = 1, 3 do
            startThread(Hero.CreatureInfo.DefaultGrow, hero, race, i, ceil(Creature.Params.Grow(TIER_TABLES[race][i][1]) * recruitment.grow_percent))
        end
    end
end)