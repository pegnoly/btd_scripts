disguise_and_reckon =
{
  position = {
    [PLAYER_1] = { x = 15, y = 45 },
    [PLAYER_2] = { x = 126, y = 57 }
  },
}

NewDayEvent.AddListener("silent_stalker_new_day",
function(day)
    if day == BTD_FREE_ROAM_DAY then
        for hero, alive in AdvMapHeroesInfo.alive_heroes do
            if hero and alive and HasHeroSkill(hero, RANGER_FEAT_DISGUISE_AND_RECKON) then
                local playerId = GetObjectOwner(hero);
                OpenCircleFog(disguise_and_reckon.position[playerId].x, disguise_and_reckon.position[playerId].y, GROUND, 3, playerId);
            end
        end
    end
end)