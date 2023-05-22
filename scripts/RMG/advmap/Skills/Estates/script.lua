-- @skill
-- Казначейство
estates =
{
  active_for_hero = {},
  initial_amount = 1000,
  per_ten_level = 5000,
}

LevelUpEvent.AddListener("BTD_RMG_estates_level_up",
function(hero)
    if HasHeroSkill(hero, PERK_ESTATES) then
        local decade = floor(GetHeroLevel(hero) / 10);
        local current_bonus = decade * estates.per_ten_level + estates.initial_amount;

        if estates.active_for_hero[hero] == nil then
            Resource.Change(hero, GOLD, current_bonus);
            estates.active_for_hero[hero] = current_bonus;
        end;

        if estates.active_for_hero[hero] ~= nil and estates.active_for_hero[hero] < current_bonus then
            local diff = current_bonus - estates.active_for_hero[hero];

            Resource.Change(hero, GOLD, diff);
            estates.active_for_hero[hero] = current_bonus;
        end;
    end;
end)