function JazazTest() 
    ChangeHeroStat("Jazaz", STAT_KNOWLEDGE, 3)
    AddHeroCreatures("Jazaz", CREATURE_IMP, 40)
    AddHeroCreatures("Jazaz", CREATURE_QUASIT, 100)
    AddHeroCreatures("Jazaz", CREATURE_BALOR, 2)
    StartCombat("Jazaz", nil, 3, CREATURE_MAGI, 10, CREATURE_ARCH_MAGI, 10, CREATURE_COMBAT_MAGE, 10)
end