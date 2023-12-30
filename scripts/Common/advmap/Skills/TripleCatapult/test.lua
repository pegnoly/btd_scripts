function TripleCatapult_Test()
    for i = 1, 2 do 
        GiveHeroSkill("Astral", SKILL_WAR_MACHINES)
    end
    sleep(5)
    GiveHeroSkill("Astral", PERK_MAGIC_BOND)
    sleep(5)
    GiveHeroSkill("Astral", PERK_CATAPULT)
    sleep(5)
    GiveHeroSkill("Astral", DEMON_FEAT_TRIPLE_CATAPULT)
    GiveHeroWarMachine("Astral", WAR_MACHINE_AMMO_CART)
end