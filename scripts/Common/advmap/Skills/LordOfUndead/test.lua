function LordOfUndead_Test(necro_lvl)
    for i = 1, necro_lvl do
        GiveHeroSkill("Effig", SKILL_NECROMANCY)
    end
    sleep()
    for i = 1, 3 do
        GiveHeroSkill("Effig", SKILL_LEARNING)
    end
    sleep()
    GiveHeroSkill("Effig", PERK_NO_REST_FOR_THE_WICKED)
    GiveHeroSkill("Effig", PERK_SCHOLAR)
    sleep()
    GiveHeroSkill("Effig", DEMON_FEAT_MASTER_OF_SECRETS)
    sleep()
    GiveHeroSkill("Effig", NECROMANCER_FEAT_LORD_OF_UNDEAD)
    sleep()
    Hero.CreatureInfo.Add("Effig", CREATURE_SKELETON, 50)
    Hero.CreatureInfo.Add("Effig", CREATURE_WALKING_DEAD, 20)
    Hero.CreatureInfo.Add("Effig", CREATURE_VAMPIRE, 7)
    sleep()
    StartCombat("Effig", nil, 3, 4, 100, 4, 100, 4, 100)
end