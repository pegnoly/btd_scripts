function LordOfUndead_Test(necro_lvl)
    for i = 1, necro_lvl do
        GiveHeroSkill("Berein", SKILL_NECROMANCY)
    end
    sleep()
    for i = 1, 3 do
        GiveHeroSkill("Berein", SKILL_LEARNING)
    end
    sleep()
    GiveHeroSkill("Berein", PERK_NO_REST_FOR_THE_WICKED)
    GiveHeroSkill("Berein", PERK_SCHOLAR)
    sleep()
    GiveHeroSkill("Berein", DEMON_FEAT_MASTER_OF_SECRETS)
    sleep()
    GiveHeroSkill("Berein", NECROMANCER_FEAT_LORD_OF_UNDEAD)
    sleep()
    Hero.CreatureInfo.Add("Berein", CREATURE_SKELETON, 200)
    Hero.CreatureInfo.Add("Berein", CREATURE_WALKING_DEAD, 100)
    Hero.CreatureInfo.Add("Berein", CREATURE_VAMPIRE, 25)
    sleep()
    StartCombat("Berein", nil, 3, 4, 100, 4, 100, 4, 100)
end