spell_give_decorators =
{
    [BANK_MAGI_VAULT] =
    function(hero, spell_count, spell_level)
        local schools_colors =
        {
            [MAGIC_SCHOOL_DESTRUCTIVE] = "/scripts/RMG/advmap/Objects/Banks/Texts/chaos.txt",
            [MAGIC_SCHOOL_DARK] = "/scripts/RMG/advmap/Objects/Banks/Texts/dark.txt",
            [MAGIC_SCHOOL_LIGHT] = "/scripts/RMG/advmap/Objects/Banks/Texts/light.txt",
            [MAGIC_SCHOOL_SUMMONING] = "/scripts/RMG/advmap/Objects/Banks/Texts/summon.txt",
        }
        local spells, s_n = {}, 0
        for i, school in {MAGIC_SCHOOL_DESTRUCTIVE, MAGIC_SCHOOL_DARK, MAGIC_SCHOOL_LIGHT, MAGIC_SCHOOL_SUMMONING} do
            for j, spell in spellsBySchools[school] do
                if (Spell.Params.Level(spell) == spell_level) and (not KnowHeroSpell(hero, spell)) then
                    s_n = s_n + 1
                    spells[s_n] = spell
                end
            end
        end
        if s_n ~= 0 then
            spell_count = s_n < spell_count and s_n or spell_count
            local already_learned_spells, a_n = {}, 0
            while spell_count > 0 do
                local spell = Random.FromTable(spells)
                if not contains(already_learned_spells, spell) then
                    a_n = a_n + 1
                    already_learned_spells[a_n] = spell
                    print("<color=red>BANK_MAGI_VAULT: <color=green> saving spell ", spell)
                    startThread(
                    function()
                        local spell_mastery = Spell.Params.Mastery(%spell)
                        local spell_school = Spell.Params.School(%spell)
                        if GetHeroSkillMastery(%hero, skillsBySchools[spell_school]) >= spell_mastery then
                            Hero.SpellInfo.TeachSpell(%hero, %spell)
                            return
                        end
                        MessageQueue.AddMessage(GetObjectOwner(%hero), {"/scripts/RMG/advmap/Objects/Banks/Texts/spell_remembered.txt"; color = %schools_colors[spell_school], spell = Spell.Params.Name(%spell)}, %hero, 7.0)
                        while GetHeroSkillMastery(%hero, skillsBySchools[spell_school]) < spell_mastery do
                            sleep()
                        end
                        Hero.SpellInfo.TeachSpell(%hero, %spell)
                        return
                    end)
                    spell_count = spell_count - 1
                end
                sleep()
            end
        end
    end
}

BTD_Banks =
{ 
	current_variants = {},
	current_cooldowns = {},
	delayed_rewards = {},

	InitBank =
	function(object)
		BTD_Banks.current_cooldowns[object] = 0
		Touch.DisableObject(object)
		Touch.SetFunction(object, "_"..object.."_touch", BTD_Banks.TouchBank)
	end,
	
	SetupVariant = 
	function(object, type)
		local info = BTD_GENERATED_BANKS_INFO[type]
		local prob = random(100) + 1
		local current_chance = 0
		for i, variant in info.Variants do
			current_chance = current_chance + variant.Chance;
			if current_chance >= prob then
				BTD_Banks.current_variants[object] = i
				break
			end
		end
		OverrideObjectTooltipNameAndDescription(object, BTD_BANKS_NAMES[type], BTD_BANKS_DIFF_NAMES[info.Variants[BTD_Banks.current_variants[object]].Difficulty])
	end,

	GenerateCreaturesSet =
	function(creatures_info)
		local current_creatures_set = {}
		local index = 1
		for i, creatures_set in creatures_info do
      local creature_prob = random(100) + 1
      local creature_chance = 0
      local current_creature = CREATURE_UNKNOWN
			for creature, params in creatures_set do 
				creature_chance = creature_chance + params.chance
				--print("Current chance: ", creature_chance)
				if creature_chance >= creature_prob then
          current_creature = creature
          --print("Creature generated: ", current_creature)
					current_creatures_set[index] = current_creature
		      current_creatures_set[index + 1] = creatures_set[current_creature].count_min + random(1 + creatures_set[current_creature].count_max - creatures_set[current_creature].count_min)
          index = index + 2
          break
				end
			end
		end
		return current_creatures_set
	end,

	TouchBank = 
	function(hero, object)
    local type = BTD_BanksInfo[object]
		local info = BTD_GENERATED_BANKS_INFO[type]
    print("<color=red>BTD_Banks.TouchBank: <color=green> info ok")
		if BTD_Banks.current_cooldowns[object] == 0 then
      print("<color=red>BTD_Banks.TouchBank: <color=green> current variant is ", BTD_Banks.current_variants[object])
			local variant = info.Variants[BTD_Banks.current_variants[object]]
			print("<color=red>BTD_Banks.TouchBank: <color=green> variant is ", BTD_Banks.current_variants[object])
			local creatures_set = BTD_Banks.GenerateCreaturesSet(variant.Creatures)
			print("Creatures set generated: ", creatures_set)
			print("<color=red>BTD_Banks.TouchBank: <color=green> creatures set is ", creatures_set)
			if MCCS_QuestionBoxForPlayers(GetObjectOwner(hero), 
										"/scripts/RMG/advmap/Objects/Banks/Names/guarded.txt") and 
				MCCS_StartCombat(hero, nil, len(creatures_set) / 2, creatures_set, 1) then
				local reward_info = {}
				if random(2) == 1 then
					reward_info = variant.RewardMin
				else
					reward_info = variant.RewardMax
				end
				startThread(BTD_Banks.GiveRewardDelayed, hero, type, reward_info)
				startThread(BTD_Banks.SetupCooldown, object, type, {count = info.RechargeCount, days = info.DaysForRecharge})
			end
		else
			MessageBoxForPlayers(GetPlayerFilter(GetObjectOwner(hero)), "/scripts/RMG/advmap/Objects/Banks/Names/cleared.txt")
			startThread(BTD_Banks.SetupDebuffs, hero, {luck = info.LuckLoss, morale = info.MoraleLoss})
		end
	end,
    
	GiveRewardDelayed =
	function(hero, bank_type, reward_info)
		BTD_Banks.delayed_rewards[GetObjectOwner(hero)] = {hero=hero, type=bank_type, info=reward_info}
		MessageBoxForPlayers(GetPlayerFilter(GetObjectOwner(hero)), "/scripts/RMG/advmap/Objects/Banks/Texts/reward.txt", "BTD_Banks.OnGiveRewardDelayedAccepted")
	end,
	
	OnGiveRewardDelayedAccepted =
	function(player)
		print("Trying to give reward to player ", player)
		for i, data in BTD_Banks.delayed_rewards do
			if GetObjectOwner(data.hero) == player then
				local hero = data.hero
				local type = data.type
				local info = data.info
				BTD_Banks.delayed_rewards[player] = nil
				print("Trying to give reward to hero ", hero)
				startThread(BTD_Banks.GiveReward, hero, type, info)
				break
			end
		end
	end,
	
	GiveReward =
	function(hero, bank_type, reward_info)
		local res_table = reward_info.Resources
		local minor_count = reward_info.MinorCount
		local major_count = reward_info.MajorCount
		local relic_count = reward_info.RelicCount
		local spell_count = reward_info.SpellCount
		local spell_level = reward_info.SpellLevel
		--
		for res, count in res_table do
			if count ~= 0 then
				Resource.Change(hero, res, count)
			end
		end
		--
		if minor_count ~= 0 then
      print("Reward: minor count ", minor_count)
			for i = 1, minor_count do
				local art = Art.Distribution.RandomMinor()
				print("Reward: minor to give ", art)
				startThread(Art.Distribution.Give, hero, art)
			end
		end
		--
		if major_count ~= 0 then
      print("Reward: major count ", major_count)
			for i = 1, major_count do
				local art = Art.Distribution.RandomMajor()
				print("Reward: major to give ", art)
        startThread(Art.Distribution.Give, hero, art)
			end
		end
		--
		if relic_count ~= 0 then
      print("Reward: relic count ", relic_count)
			for i = 1, relic_count do
				local art = Art.Distribution.RandomRelic()
				print("Reward: relic to give ", art)
        startThread(Art.Distribution.Give, hero, art)
			end
		end
		--
		if spell_count ~= 0 then
        if bank_type == BANK_MAGI_VAULT then
            print("Bank of type ", bank_type, " has custom decorator for spell giving")
            startThread(spell_give_decorators[BANK_MAGI_VAULT], hero, spell_count, spell_level)
        else
            startThread(BTD_Banks.CommonGiveSpells, hero, spell_count, spell_level)
        end
		end
	end,
	
	CommonGiveSpells =
	function(hero, spell_count, spell_level)
      local possible_spells = Hero.SpellInfo.GetLearnableSpellsByLevel(hero, spell_level)
      if possible_spells then
          spell_count = len(possible_spells) < spell_count and len(possible_spells) or spell_count
          local already_learned_spells, n = {}, 0
          while spell_count > 0 do
              local spell = Random.FromTable(possible_spells)
              if not contains(already_learned_spells, spell) then
                  n = n + 1
                  already_learned_spells[n] = spell
                  Hero.SpellInfo.TeachSpell(hero, spell)
                  spell_count = spell_count - 1
              end
              sleep()
          end
      end
	end,

	SetupCooldown =
	function(object, type, recharge_info)
    print("Setting up cooldown for object ", object, " of type ", type, ", recharge info - ", recharge_info)
		if recharge_info.count ~= 0 then
			BTD_Banks.current_cooldowns[object] = recharge_info.days
			OverrideObjectTooltipNameAndDescription(object, BTD_BANKS_NAMES[type], "/scripts/RMG/advmap/Objects/Banks/Names/on_cooldown.txt")
			NewDayEvent.AddListener("BTD_banks_"..object.."_cooldown_listener",
			function(day)
				BTD_Banks.current_cooldowns[%object] = BTD_Banks.current_cooldowns[%object]	- 1
				if BTD_Banks.current_cooldowns[%object]	== 0 then
					startThread(BTD_Banks.SetupVariant, %object, %type)
					NewDayEvent.RemoveListener("BTD_banks_"..%object.."_cooldown_listener")
				end
			end)
		else
			BTD_Banks.current_cooldowns[object] = -1
			OverrideObjectTooltipNameAndDescription(object, BTD_BANKS_NAMES[type], "/scripts/RMG/advmap/Objects/Banks/Names/not_avaliable.txt")
		end
	end,

	SetupDebuffs =
	function(hero, debuff_info)
		if debuff_info.luck ~= 0 then
			GiveHeroBattleBonus(hero, HERO_BATTLE_BONUS_LUCK, -debuff_info.luck)
		end
		if debuff_info.morale ~= 0 then
			GiveHeroBattleBonus(hero, HERO_BATTLE_BONUS_MORALE, -debuff_info.morale)
		end
	end,

	Init = 
	function()
		for bank, type in BTD_BanksInfo do
            print(bank)
			startThread(BTD_Banks.InitBank, bank)
			startThread(BTD_Banks.SetupVariant, bank, type)
		end
	end,
}

while not MapLoadingEvent and BTD_BanksInfo do
	sleep()
end

MapLoadingEvent.AddListener("test_list",
function()
	startThread(BTD_Banks.Init)
end)