MGUILD_DEBUG_LEVEL = 0

function MGuildTest()
    local town = Player.GetTowns(PLAYER_1)[1]
    for i = 1, 4 do
        UpgradeTownBuilding(town, TOWN_BUILDING_MAGIC_GUILD)
    end

    for i = 1, 3 do
        GiveHeroSkill("Inagost", SKILL_DESTRUCTIVE_MAGIC)
        GiveHeroSkill("Inagost", SKILL_SUMMONING_MAGIC)
    end
end