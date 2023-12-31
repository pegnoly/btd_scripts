SKILL_SHOP_PATH = "/MapObjects/SkillShop/FX/"

while not FX and FX.Effects do
  sleep()
end

SKILL_DARK_MAGIC_INACTIVE = SKILL_DARK_MAGIC + 1000
SKILL_LEADERSHIP_INACTIVE = SKILL_LEADERSHIP + 1000
SKILL_DEFENCE_INACTIVE = SKILL_DEFENCE + 1000
SKILL_WAR_MACHINES_INACTIVE = SKILL_WAR_MACHINES + 1000
SKILL_OFFENCE_INACTIVE = SKILL_OFFENCE + 1000
SKILL_LOGISTICS_INACTIVE = SKILL_LOGISTICS + 1000
SKILL_LIGHT_MAGIC_INACTIVE = SKILL_LIGHT_MAGIC + 1000
SKILL_LUCK_INACTIVE = SKILL_LUCK + 1000
SKILL_SORCERY_INACTIVE = SKILL_SORCERY + 1000
SKILL_DESTRUCTIVE_MAGIC_INACTIVE = SKILL_DESTRUCTIVE_MAGIC + 1000
SKILL_SUMMONING_MAGIC_INACTIVE = SKILL_SUMMONING_MAGIC + 1000
SKILL_LEARNING_INACTIVE = SKILL_LEARNING + 1000
HERO_SKILL_BARBARIAN_LEARNING_INACTIVE = HERO_SKILL_BARBARIAN_LEARNING + 1000
HERO_SKILL_SHATTER_DESTRUCTIVE_MAGIC_INACTIVE = HERO_SKILL_SHATTER_DESTRUCTIVE_MAGIC + 1000
HERO_SKILL_SHATTER_LIGHT_MAGIC_INACTIVE = HERO_SKILL_SHATTER_LIGHT_MAGIC + 1000
HERO_SKILL_SHATTER_SUMMONING_MAGIC_INACTIVE = HERO_SKILL_SHATTER_SUMMONING_MAGIC + 1000
HERO_SKILL_SHATTER_DARK_MAGIC_INACTIVE = HERO_SKILL_SHATTER_DARK_MAGIC + 1000
HERO_SKILL_VOICE_INACTIVE = HERO_SKILL_VOICE + 1000

while not HERO_SKILL_VOICE_INACTIVE do
    sleep()
end

FX.Effects[SKILL_LEADERSHIP] = SKILL_SHOP_PATH.."Leadership/Active/active.(Effect)"
FX.Effects[SKILL_DEFENCE] = SKILL_SHOP_PATH.."Defence/Active/active.(Effect)"  
FX.Effects[SKILL_WAR_MACHINES] = SKILL_SHOP_PATH.."WarMachines/Active/active.(Effect)"  
FX.Effects[SKILL_OFFENCE] = SKILL_SHOP_PATH.."Offence/Active/active.(Effect)"  
FX.Effects[SKILL_LOGISTICS] = SKILL_SHOP_PATH.."Logistics/Active/active.(Effect)"  
FX.Effects[SKILL_LIGHT_MAGIC] = SKILL_SHOP_PATH.."LightMagic/Active/active.(Effect)"  
FX.Effects[SKILL_LUCK] = SKILL_SHOP_PATH.."Luck/Active/active.(Effect)"  
FX.Effects[SKILL_DARK_MAGIC] = SKILL_SHOP_PATH.."DarkMagic/Active/active.(Effect)"  
FX.Effects[SKILL_SORCERY] = SKILL_SHOP_PATH.."Sorcery/Active/active.(Effect)"  
FX.Effects[SKILL_DESTRUCTIVE_MAGIC] = SKILL_SHOP_PATH.."DestructiveMagic/Active/active.(Effect)"  
FX.Effects[SKILL_SUMMONING_MAGIC] = SKILL_SHOP_PATH.."SummoningMagic/Active/active.(Effect)"  
FX.Effects[SKILL_LEARNING] = SKILL_SHOP_PATH.."Learning/Active/active.(Effect)"  
FX.Effects[HERO_SKILL_BARBARIAN_LEARNING] = SKILL_SHOP_PATH.."Learning/Active/active.(Effect)"  
FX.Effects[HERO_SKILL_SHATTER_DESTRUCTIVE_MAGIC] = SKILL_SHOP_PATH.."ShatterDestructive/Active/active.(Effect)"
FX.Effects[HERO_SKILL_SHATTER_LIGHT_MAGIC] = SKILL_SHOP_PATH.."ShatterLight/Active/active.(Effect)"    
FX.Effects[HERO_SKILL_SHATTER_SUMMONING_MAGIC] = SKILL_SHOP_PATH.."ShatterSummon/Active/active.(Effect)"    
FX.Effects[HERO_SKILL_SHATTER_DARK_MAGIC] = SKILL_SHOP_PATH.."ShatterDark/Active/active.(Effect)"    
FX.Effects[HERO_SKILL_VOICE] = SKILL_SHOP_PATH.."Voice/Active/active.(Effect)"  
-- inactives
FX.Effects[SKILL_LEADERSHIP_INACTIVE] = SKILL_SHOP_PATH.."Leadership/Inactive/inactive.(Effect)"
FX.Effects[SKILL_DEFENCE_INACTIVE] = SKILL_SHOP_PATH.."Defence/Inactive/inactive.(Effect)"  
FX.Effects[SKILL_WAR_MACHINES_INACTIVE] = SKILL_SHOP_PATH.."WarMachines/Inactive/inactive.(Effect)"  
FX.Effects[SKILL_OFFENCE_INACTIVE] = SKILL_SHOP_PATH.."Offence/Inactive/inactive.(Effect)"  
FX.Effects[SKILL_LOGISTICS_INACTIVE] = SKILL_SHOP_PATH.."Logistics/Inactive/inactive.(Effect)"  
FX.Effects[SKILL_LIGHT_MAGIC_INACTIVE] = SKILL_SHOP_PATH.."LightMagic/Inactive/inactive.(Effect)"  
FX.Effects[SKILL_LUCK_INACTIVE] = SKILL_SHOP_PATH.."Luck/Inactive/inactive.(Effect)"  
FX.Effects[SKILL_DARK_MAGIC_INACTIVE] = SKILL_SHOP_PATH.."DarkMagic/Inactive/inactive.(Effect)"  
FX.Effects[SKILL_SORCERY_INACTIVE] = SKILL_SHOP_PATH.."Sorcery/Inactive/inactive.(Effect)"  
FX.Effects[SKILL_DESTRUCTIVE_MAGIC_INACTIVE] = SKILL_SHOP_PATH.."DestructiveMagic/Inactive/inactive.(Effect)"  
FX.Effects[SKILL_SUMMONING_MAGIC_INACTIVE] = SKILL_SHOP_PATH.."SummoningMagic/Inactive/inactive.(Effect)"  
FX.Effects[SKILL_LEARNING_INACTIVE] = SKILL_SHOP_PATH.."Learning/Inactive/inactive.(Effect)"  
FX.Effects[HERO_SKILL_BARBARIAN_LEARNING_INACTIVE] = SKILL_SHOP_PATH.."Learning/Inactive/inactive.(Effect)"  
FX.Effects[HERO_SKILL_SHATTER_DESTRUCTIVE_MAGIC_INACTIVE] = SKILL_SHOP_PATH.."ShatterDestructive/Inactive/inactive.(Effect)"
FX.Effects[HERO_SKILL_SHATTER_LIGHT_MAGIC_INACTIVE] = SKILL_SHOP_PATH.."ShatterLight/Inactive/inactive.(Effect)"    
FX.Effects[HERO_SKILL_SHATTER_SUMMONING_MAGIC_INACTIVE] = SKILL_SHOP_PATH.."ShatterSummon/Inactive/inactive.(Effect)"    
FX.Effects[HERO_SKILL_SHATTER_DARK_MAGIC_INACTIVE] = SKILL_SHOP_PATH.."ShatterDark/Inactive/inactive.(Effect)"    
FX.Effects[HERO_SKILL_VOICE_INACTIVE] = SKILL_SHOP_PATH.."Voice/Inactive/inactive.(Effect)" 


skill_shop =
{
  shops = {"skill_shop_p1", "skill_shop2_p1", "skill_shop_p2", "skill_shop2_p2"},
  path = "/scripts/Duel/advmap/Objects/SkillShop/",
  skill_names =
  {
    [SKILL_LEADERSHIP] = SKILL_SHOP_PATH.."Leadership.txt",
    [SKILL_DEFENCE] = SKILL_SHOP_PATH.."Defence.txt",
    [SKILL_WAR_MACHINES] = SKILL_SHOP_PATH.."WarMachines.txt",
    [SKILL_OFFENCE] = SKILL_SHOP_PATH.."Offence.txt",
    [SKILL_LOGISTICS] = SKILL_SHOP_PATH.."Logistics.txt",
    [SKILL_LIGHT_MAGIC] = SKILL_SHOP_PATH.."LightMagic.txt",
    [SKILL_LUCK] = SKILL_SHOP_PATH.."Luck.txt",
    [SKILL_DARK_MAGIC] = SKILL_SHOP_PATH.."DarkMagic.txt",
    [SKILL_SORCERY] = SKILL_SHOP_PATH.."Sorcery.txt",
    [SKILL_DESTRUCTIVE_MAGIC] = SKILL_SHOP_PATH.."DestructiveMagic.txt",
    [SKILL_SUMMONING_MAGIC] = SKILL_SHOP_PATH.."SummoningMagic.txt",
    [SKILL_LEARNING] = SKILL_SHOP_PATH.."Learning.txt",
    [HERO_SKILL_BARBARIAN_LEARNING] = SKILL_SHOP_PATH.."Learning.txt",
    [HERO_SKILL_SHATTER_DESTRUCTIVE_MAGIC] = SKILL_SHOP_PATH.."ShatterChaos.txt",
    [HERO_SKILL_SHATTER_LIGHT_MAGIC] = SKILL_SHOP_PATH.."ShatterLight.txt",
    [HERO_SKILL_SHATTER_SUMMONING_MAGIC] = SKILL_SHOP_PATH.."ShatterSummon.txt",
    [HERO_SKILL_SHATTER_DARK_MAGIC] = SKILL_SHOP_PATH.."DarkShatter.txt",
    [HERO_SKILL_VOICE] = SKILL_SHOP_PATH.."Voice.txt",
  },

  skill_probs_by_class =
  {
    -- рыцарь
    [HERO_CLASS_KNIGHT] =
    {
      [SKILL_LEADERSHIP] = 15,
      [SKILL_DEFENCE] = 15,
      --[SKILL_TRAINING] = 10,
      [SKILL_WAR_MACHINES] = 10,
      [SKILL_OFFENCE] = 10,
      [SKILL_LOGISTICS] = 8,
      [SKILL_LIGHT_MAGIC] = 8,
      [SKILL_LUCK] = 8,
      [SKILL_DARK_MAGIC] = 8,
    },
    -- рейнджер
    [HERO_CLASS_RANGER] =
    {
      [SKILL_LEADERSHIP] = 8,
      [SKILL_DEFENCE] = 10,
      --[SKILL_AVENGER] = 10,
      [SKILL_OFFENCE] = 6,
      [SKILL_LOGISTICS] = 15,
      [SKILL_LIGHT_MAGIC] = 8,
      [SKILL_LUCK] = 15,
      [SKILL_SORCERY] = 8,
      [SKILL_DESTRUCTIVE_MAGIC] = 8,
      [SKILL_LEARNING] = 10
    },
    -- маг
    [HERO_CLASS_WIZARD] =
    {
      --[SKILL_ARTIFICIER] = 10,
      [SKILL_WAR_MACHINES] = 8,
      [SKILL_LIGHT_MAGIC] = 8,
      [SKILL_LUCK] = 8,
      [SKILL_DARK_MAGIC] = 8,
      [SKILL_SORCERY] = 10,
      [SKILL_DESTRUCTIVE_MAGIC] = 8,
      [SKILL_SUMMONING_MAGIC] = 15,
      [SKILL_LEARNING] = 15
    },
    -- демон
    [HERO_CLASS_DEMON_LORD] =
    {
      [SKILL_DEFENCE] = 8,
      --[SKILL_GATING] = 10,
      [SKILL_WAR_MACHINES] = 10,
      [SKILL_OFFENCE] = 15,
      [SKILL_LOGISTICS] = 15,
      [SKILL_LUCK] = 8,
      [SKILL_DARK_MAGIC] = 8,
      [SKILL_SORCERY] = 8,
      [SKILL_DESTRUCTIVE_MAGIC] = 10,
    },
    -- некромант
    [HERO_CLASS_NECROMANCER] =
    {
      [SKILL_DEFENCE] = 10,
      --[SKILL_NECROMANCY] = 15,
      [SKILL_OFFENCE] = 8,
      [SKILL_LOGISTICS] = 8,
      [SKILL_DARK_MAGIC] = 15,
      [SKILL_SORCERY] = 10,
      [SKILL_DESTRUCTIVE_MAGIC] = 8,
      [SKILL_SUMMONING_MAGIC] = 10,
      [SKILL_LEARNING] = 8
    },
    -- чернокнижник
    [HERO_CLASS_WARLOCK] =
    {
      --[SKILL_INVOCATION] = 10,
      [SKILL_WAR_MACHINES] = 8,
      [SKILL_OFFENCE] = 15,
      [SKILL_LOGISTICS] = 8,
      [SKILL_LUCK] = 8,
      [SKILL_SORCERY] = 10,
      [SKILL_DESTRUCTIVE_MAGIC] = 15,
      [SKILL_SUMMONING_MAGIC] = 10,
      [SKILL_LEARNING] = 8
    },
    -- гном
    [HERO_CLASS_RUNEMAGE] =
    {
      [SKILL_LEADERSHIP] = 8,
      [SKILL_DEFENCE] = 15,
      --[HERO_SKILL_RUNELORE] = 10,
      [SKILL_WAR_MACHINES] = 15,
      [SKILL_OFFENCE] = 8,
      [SKILL_LIGHT_MAGIC] = 8,
      [SKILL_LUCK] = 8,
      [SKILL_DESTRUCTIVE_MAGIC] = 10,
      [SKILL_SUMMONING_MAGIC] = 4,
      [SKILL_LEARNING] = 8
    },
    -- орк
    [HERO_CLASS_BARBARIAN] =
    {
      [SKILL_LEADERSHIP] = 10,
      [SKILL_DEFENCE] = 10,
      --[HERO_SKILL_DEMONIC_RAGE] = 10,
      [SKILL_WAR_MACHINES] = 8,
      [SKILL_OFFENCE] = 15,
      [SKILL_LOGISTICS] = 15,
      [SKILL_LUCK] = 8,
      [HERO_SKILL_SHATTER_DESTRUCTIVE_MAGIC] = 5,
      [HERO_SKILL_SHATTER_LIGHT_MAGIC] = 5,
      [HERO_SKILL_SHATTER_SUMMONING_MAGIC] = 5,
      [HERO_SKILL_SHATTER_DARK_MAGIC] = 5
    }
  },

  skill_costs_by_rarity =
  {
    [15] = 3500,
    [10] = 4500,
    [8] = 5000,
    [6] = 6000,
    [5] = 6000,
    [4] = 7000,
  },

  used_by_player = {[PLAYER_1] = nil, [PLAYER_2] = nil},

  player_return_position = {
    [PLAYER_1] = {}, [PLAYER_2] = {}
  }
}

function SkillShop_Init(hero)
    local class = Hero.Params.Class(hero)
    local count = 0
    for skill, _ in skill_shop.skill_probs_by_class[class] do
        count = count + 1
        local actual_skill = skill
        if HasHeroSkill(hero, skill) then
            actual_skill = skill + 1000
        end
        local placeholder = "skill_shop_placeholder_"..GetObjectOwner(hero)..""..count
        if actual_skill == skill then
            Touch.DisableObject(placeholder, DISABLED_INTERACT, skill_shop.skill_names[skill])
        else
            Touch.DisableObject(placeholder, DISABLED_INTERACT, skill_shop.skill_names[skill], skill_shop.path.."already_learned_skill.txt")
        end
        PlayVisualEffect(
            FX.Effects[actual_skill]..".xdb#xpointer(/Effect)",
            placeholder,
            placeholder.."_fx"
        )
        Touch.SetFunction(placeholder, "_touch_skill_shop_placeholder",
        function(hero, object)
            startThread(SkillShop_TryToLearnSkill, hero, object, %actual_skill)
        end)
    end
    --
    for i = count + 1, 10 do
        local placeholder = "skill_shop_placeholder_"..GetObjectOwner(hero)..""..i
        RemoveObject(placeholder)
    end
end

function SkillShop_TryToLearnSkill(hero, object, skill)
    local owner = GetObjectOwner(hero)
    if skill > 1000 then
        startThread(MCCS_MessageBoxForPlayers, owner, skill_shop.path.."skill_is_known.txt")
    else
        local class = Hero.Params.Class(hero)
        local cost = economy.GetCostWithEconomy(hero, skill_shop.skill_costs_by_rarity[skill_shop.skill_probs_by_class[class][skill]])
        local economed_gold = skill_shop.skill_costs_by_rarity[skill_shop.skill_probs_by_class[class][skill]] - cost
        if MCCS_QuestionBoxForPlayers(
            owner,
            {skill_shop.path.."wanna_learn_skill.txt"; skill_name = skill_shop.skill_names[skill], cost = cost}
        ) then
            local gold = GetPlayerResource(owner, GOLD)
            if gold >= cost then
                GiveHeroSkill(hero, skill)
                SetPlayerResource(owner, GOLD, gold - cost)
                economy.EconomGold(hero, economed_gold)
                skill_shop.used_by_player[owner] = 1
                local saved_position = skill_shop.player_return_position[owner]
                SetObjectPosition(hero, saved_position.x, saved_position.y, saved_position.f)
            else
                startThread(MCCS_MessageBoxForPlayers, owner, skill_shop.path.."not_enough_gold.txt")
            end
        end
    end
end

MapLoadingEvent.AddListener("skill_shop_init_event",
function()
    for i, shop in {"skill_shop_p1", "skill_shop2_p1", "skill_shop_p2", "skill_shop2_p2"} do
        Touch.DisableObject(shop)
        Touch.SetFunction(shop, "_skill_shop_touch",
        function(hero, object)
            local player = GetObjectOwner(hero)
            --
            if not skill_shop.used_by_player[player] then
                --
                local skill_count = 0
                for skill, _ in skill_shop.skill_names do
                    if GetHeroSkillMastery(hero, skill) > 0 then
                        skill_count = skill_count + 1
                    end
                end
                -- 
                if skill_count == 5 then
                    startThread(MCCS_MessageBoxForPlayers, player, skill_shop.path.."cant_learn.txt")
                    return
                end
                startThread(SkillShop_Init, hero)
                local x, y, f = RegionToPoint("skill_shop_entry_point_"..player)
                local px, py, pf = GetObjectPosition(hero)
                skill_shop.player_return_position[player] = {x = px, y = py, f = pf}
                SetObjectPosition(hero, x, y, f)
            else
                startThread(MCCS_MessageBoxForPlayers, player, skill_shop.path.."already_used.txt")
            end
        end)
    end
    --
    for i, portal in {"skill_shop_out_p1", "skill_shop_out_p2"} do
        Touch.DisableObject(portal, DISABLED_INTERACT)
        Touch.SetFunction(portal, "_touch_skill_shop_out",
        function(hero, object)
            local saved_position = skill_shop.player_return_position[GetObjectOwner(hero)]
            SetObjectPosition(hero, saved_position.x, saved_position.y, saved_position.f)
        end)
    end
end)