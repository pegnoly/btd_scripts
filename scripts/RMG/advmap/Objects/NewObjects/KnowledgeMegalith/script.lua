KnowledgeMegalith = 
{
    path = "/scripts/RMG/advmap/Objects/NewObjects/KnowledgeMegalith/",
    used_by_hero = {},

    exp_amount = 4500
}

AddHeroEvent.AddListener("BTD_knowledge_megalith_add_hero_listener",
function(hero)
	KnowledgeMegalith.used_by_hero[hero] = nil
end)