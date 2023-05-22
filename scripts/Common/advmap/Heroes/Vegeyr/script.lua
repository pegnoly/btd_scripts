vegeyr_spec =
{
  heroes = {"Vegeyr"},
  level = 10
}

LevelUpEvent.AddListener("BTD_vegeyr_lvl_up",
function(hero)
  if contains(vegeyr_spec.heroes, hero) and GetHeroLevel(hero) == vegeyr_spec.level then
    for _, spellId in { 7, 229 } do
       TeachHeroSpell(hero, spellId);
       MessageQueue.AddMessage(GetObjectOwner(hero), {'/Text/Default/spell_learned.txt'; name = Spell.Params.Name(spellId)}, hero, 6.0)
    end;
  end
end)