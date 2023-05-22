kujin_spec =
{
  heroes = {"Kujin"},
  lvl_divisor = 10,
  warcries =
  {
    SPELL_WARCRY_RALLING_CRY,
    SPELL_WARCRY_CALL_OF_BLOOD,
    SPELL_WARCRY_WORD_OF_THE_CHIEF,
    SPELL_WARCRY_FEAR_MY_ROAR,
    SPELL_WARCRY_BATTLECRY,
    SPELL_WARCRY_SHOUT_OF_MANY
  }
}


LevelUpEvent.AddListener("BTD_rmg_kujin_spec_level_up_event",
function(hero)
  if contains(kujin_spec.heroes, hero) then
    local level = GetHeroLevel(hero)
    if level > 1 and mod(level, kujin_spec.lvl_divisor) == 0 then
      local unknown_warcries, n = {}, 0
      for i, spell in kujin_spec.warcries do
        if not KnowHeroSpell(hero, spell) then
          n = n + 1
          unknown_warcries[n] = spell
        end
      end
      if n > 0 then
        local spell_to_learn = Random.FromTable(unknown_warcries)
        
        TeachHeroSpell(hero, spell_to_learn);
        MessageQueue.AddMessage(GetObjectOwner(hero), {'/Text/Default/spell_learned.txt'; name = Spell.Params.Name(spell_to_learn)}, hero, 6.0)
      end
    end
  end
end)