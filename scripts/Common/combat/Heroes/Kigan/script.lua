kigan_spec =
{
    heroes = {"Hero9", "Hero91", "Hero92"},
    goblins = {CREATURE_GOBLIN, CREATURE_GOBLIN_TRAPPER, CREATURE_GOBLIN_DEFILER},
    [ATTACKER] = 
    {
        atb_return_position = -1,
		cast_available = 1
    },
    [DEFENDER] = 
    {
        atb_return_position = -1,
		cast_available = 1
    }
}

if contains(kigan_spec.heroes, GetHeroName(GetAttackerHero())) then
    local hero = GetHeroName(GetAttackerHero())
    local voice_mastery = ceil(GetGameVar(hero.."_VOICE_MASTERY") + 0)
    kigan_spec[ATTACKER] =
    {
        atb_return_position = 0.1 * voice_mastery,
		cast_available = 1
    }
    AddCombatFunction(CombatFunctions.ATTACKER_HERO_MOVE, "kigan_spec_attacker_hero_move",
    function()
		if kigan_spec[ATTACKER].cast_available == 1 then
			if not KiganSpec_WarcryCast(ATTACKER) then
				kigan_spec[ATTACKER].cast_available = 0
			end
		end
		while combatReadyPerson() do
			sleep()
		end
		if kigan_spec[ATTACKER].cast_available == 1 then
			kigan_spec[ATTACKER].cast_available = 0
			setATB(GetAttackerHero(), 1)
		else
			kigan_spec[ATTACKER].cast_available = 1
		end
		return 1
    end)
end

if GetDefenderHero() and contains(kigan_spec.heroes, GetHeroName(GetDefenderHero())) then
    local hero = GetHeroName(GetDefenderHero())
    local voice_mastery = ceil(GetGameVar(hero.."_VOICE_MASTERY") + 0)
    kigan_spec[DEFENDER] =
    {
        atb_return_position = 0.1 * voice_mastery,
		cast_available = 1
    }
    AddCombatFunction(CombatFunctions.DEFENDER_HERO_MOVE, "kigan_spec_defender_hero_move",
    function()
		if kigan_spec[DEFENDER].cast_available == 1 then
			if not KiganSpec_WarcryCast(DEFENDER) then
				kigan_spec[DEFENDER].cast_available = 0
			end
		end
		while combatReadyPerson() do
			sleep()
		end
		if kigan_spec[DEFENDER].cast_available == 1 then
			kigan_spec[DEFENDER].cast_available = 0
			setATB(GetDefenderHero(), 1)
		else
			kigan_spec[DEFENDER].cast_available = 1
		end
		return 1
    end)
end

function KiganSpec_WarcryCast(side)
	local goblins_to_cast, g_n = {}, 0
	for i, creature in GetCreatures(side) do
		local type = GetCreatureType(creature)
		if contains(kigan_spec.goblins, type) then
			g_n = g_n + 1
			goblins_to_cast[g_n] = creature
		end
	end
	sleep()
	if g_n ~= 0 then
		local hero = GetHero(side)
		local current_mana = GetUnitManaPoints(hero)
		local mana_to_add = current_mana + 1000
		SetUnitManaPoints(hero, mana_to_add)
		while GetUnitManaPoints(hero) ~= mana_to_add do
			sleep()
		end
		for i, goblin in goblins_to_cast do
			pcall(UnitCastAimedSpell, hero, SPELL_WARCRY_CALL_OF_BLOOD, goblin)
		end
		sleep()
		SetUnitManaPoints(hero, current_mana)
		return 1
	end
	return nil
end