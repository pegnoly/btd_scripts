while not MCCS_CREATURE_GENERATED_TABLE do
    sleep()
  end
  
  Creature =
  {
      Params =
      {
  
          Exception =
          function(creature, ex)
              print("<color=red>Creature.Params.Exception: <color=green> creature - ", creature, ", param - ", ex)
          end,
  
          IsGeneratable =
          --- Генерируется ли существо на карте
          ---@param creature CreatureID id существа
          ---@return boolean generatable генерируется/нет
          function(creature)
              errorHook(
              function()
                  Creature.Params.Exception(%creature, "is_generatable")
              end)
              local answer = MCCS_CREATURE_GENERATED_TABLE[creature] and
                              MCCS_CREATURE_GENERATED_TABLE[creature].is_generatable or MCCS_CREATURE_GENERATED_TABLE[GetCreatureType(creature)].is_generatable
              return answer
          end,
  
          Power =
          --- Возвращает силу существа
          ---@param creature CreatureID id существа
          ---@return integer power сила
          function(creature)
              errorHook(
              function()
                  Creature.Params.Exception(%creature, "power")
              end)
              local answer = MCCS_CREATURE_GENERATED_TABLE[creature] and
                              MCCS_CREATURE_GENERATED_TABLE[creature].power or MCCS_CREATURE_GENERATED_TABLE[GetCreatureType(creature)].power
              return answer
          end,
  
          Tier =
          --- Возвращает уровень существа
          ---@param creature CreatureID id существа
          ---@return integer tier уровень
          function(creature)
              errorHook(
              function()
                  Creature.Params.Exception(%creature, "tier")
              end)
              local answer = MCCS_CREATURE_GENERATED_TABLE[creature] and
                              MCCS_CREATURE_GENERATED_TABLE[creature].tier or MCCS_CREATURE_GENERATED_TABLE[GetCreatureType(creature)].tier
              return answer
          end,
  
          Name =
          --- Возвращает путь к имени существа
          ---@param creature CreatureID id существа
          ---@return string path путь
          function(creature)
              errorHook(
              function()
                  Creature.Params.Exception(%creature, "name")
              end)
              local answer = MCCS_CREATURE_GENERATED_TABLE[creature] and
                              MCCS_CREATURE_GENERATED_TABLE[creature].name or MCCS_CREATURE_GENERATED_TABLE[GetCreatureType(creature)].name
              return answer
          end,
  
          Town =
          --- Возвращает город существа
          ---@param creature CreatureID id существа
          ---@return TownType town тип города
          function(creature)
              errorHook(
              function()
                  Creature.Params.Exception(%creature, "town")
              end)
              local answer = MCCS_CREATURE_GENERATED_TABLE[creature] and
                              MCCS_CREATURE_GENERATED_TABLE[creature].town or MCCS_CREATURE_GENERATED_TABLE[GetCreatureType(creature)].town
              return answer
          end,
  
          Size =
          --- Возвращает размер существа
          ---@param creature CreatureID id существа
          ---@return integer size размер
          function(creature)
          errorHook(
              function()
                  Creature.Params.Exception(%creature, "size")
              end)
              local answer = MCCS_CREATURE_GENERATED_TABLE[creature] and
                              MCCS_CREATURE_GENERATED_TABLE[creature].size or MCCS_CREATURE_GENERATED_TABLE[GetCreatureType(creature)].size
              return answer
          end,
  
          Exp =
          --- Возвращает число опыта за убийство существа
          ---@param creature CreatureID id существа
          ---@return integer exp опыт
          function(creature)
              errorHook(
              function()
                  Creature.Params.Exception(%creature, "exp")
              end)
              local answer = MCCS_CREATURE_GENERATED_TABLE[creature] and
                              MCCS_CREATURE_GENERATED_TABLE[creature].exp or MCCS_CREATURE_GENERATED_TABLE[GetCreatureType(creature)].exp
              return answer
          end,
  
          Initiative =
          --- Возвращает инициативу существа
          ---@param creature CreatureID id существа
          ---@return integer ini инициатива
          function(creature)
              errorHook(
              function()
                  Creature.Params.Exception(%creature, "initiative")
              end)
              local answer = MCCS_CREATURE_GENERATED_TABLE[creature] and
                              MCCS_CREATURE_GENERATED_TABLE[creature].ini or MCCS_CREATURE_GENERATED_TABLE[GetCreatureType(creature)].ini
              return answer
          end,
  
          Speed =
          --- Возвращает скорость существа
          ---@param creature CreatureID id существа
          ---@return integer speed скорость
          function(creature)
              errorHook(
              function()
                  Creature.Params.Exception(%creature, "speed")
              end)
              local answer = MCCS_CREATURE_GENERATED_TABLE[creature] and
                              MCCS_CREATURE_GENERATED_TABLE[creature].speed or MCCS_CREATURE_GENERATED_TABLE[GetCreatureType(creature)].speed
              return answer
          end,
  
          Attack =
          --- Возвращает нападение существа
          ---@param creature CreatureID id существа
          ---@return integer attack нападение
          function(creature)
              errorHook(
              function()
                  Creature.Params.Exception(%creature, "attack")
              end)
              local answer = MCCS_CREATURE_GENERATED_TABLE[creature] and
                              MCCS_CREATURE_GENERATED_TABLE[creature].attack or MCCS_CREATURE_GENERATED_TABLE[GetCreatureType(creature)].attack
              return answer
          end,
  
          Defence =
          --- Возвращает защиту существа
          ---@param creature CreatureID id существа
          ---@return integer defence защита
          function(creature)
              errorHook(
              function()
                  Creature.Params.Exception(%creature, "defence")
              end)
              local answer = MCCS_CREATURE_GENERATED_TABLE[creature] and
                              MCCS_CREATURE_GENERATED_TABLE[creature].defence or MCCS_CREATURE_GENERATED_TABLE[GetCreatureType(creature)].defence
              return answer
          end,
  
          DamageMin =
          --- Возвращает нижнюю планку урона существа
          ---@param creature CreatureID id существа
          ---@return integer damage_min планка урона
          function(creature)
              errorHook(
              function()
                  Creature.Params.Exception(%creature, "damage_min")
              end)
              local answer = MCCS_CREATURE_GENERATED_TABLE[creature] and
                              MCCS_CREATURE_GENERATED_TABLE[creature].damage_min or MCCS_CREATURE_GENERATED_TABLE[GetCreatureType(creature)].damage_min
              return answer
          end,
  
          DamageMax =
          --- Возвращает верхнюю планку урона существа
          ---@param creature CreatureID id существа
          ---@return integer dmg_max планка урона
          function(creature)
              errorHook(
              function()
                  Creature.Params.Exception(%creature, "damage_max")
              end)
              local answer = MCCS_CREATURE_GENERATED_TABLE[creature] and
                              MCCS_CREATURE_GENERATED_TABLE[creature].damage_max or MCCS_CREATURE_GENERATED_TABLE[GetCreatureType(creature)].damage_max
              return answer
          end,
  
          Health =
          --- Возвращает здоровье существа
          ---@param creature CreatureID id существа
          ---@return integer hp здоровье
          function(creature)
              errorHook(
              function()
                  Creature.Params.Exception(%creature, "health")
              end)
              local answer = MCCS_CREATURE_GENERATED_TABLE[creature] and
                              MCCS_CREATURE_GENERATED_TABLE[creature].health or MCCS_CREATURE_GENERATED_TABLE[GetCreatureType(creature)].health
              return answer
          end,
  
          Cost =
          --- Возвращает стоимость существа в золоте
          ---@param creature CreatureID id существа
          ---@return integer cost стоимость
          function(creature)
              errorHook(
              function()
                  Creature.Params.Exception(%creature, "cost")
              end)
              local answer = MCCS_CREATURE_GENERATED_TABLE[creature] and
                              MCCS_CREATURE_GENERATED_TABLE[creature].cost or MCCS_CREATURE_GENERATED_TABLE[GetCreatureType(creature)].cost
              return answer
          end,
  
          Grow =
          --- Возвращает прирост существа
          ---@param creature CreatureID id существа
          ---@return integer grow прирост
          function(creature)
              errorHook(
              function()
                  Creature.Params.Exception(%creature, "grow")
              end)
              local answer = MCCS_CREATURE_GENERATED_TABLE[creature] and
                              MCCS_CREATURE_GENERATED_TABLE[creature].grow or MCCS_CREATURE_GENERATED_TABLE[GetCreatureType(creature)].grow
              return answer
          end,
  
          FirstElement =
          --- Возвращает первый магический элемент существа
          ---@param creature CreatureID id существа
          ---@return CreatureMagicElementType element элемент
          function(creature)
              errorHook(
              function()
                  Creature.Params.Exception(%creature, "first_element")
              end)
              local answer = MCCS_CREATURE_GENERATED_TABLE[creature] and
                              MCCS_CREATURE_GENERATED_TABLE[creature].first_element or MCCS_CREATURE_GENERATED_TABLE[GetCreatureType(creature)].first_element
              return answer
          end,
  
          SecondElement =
          --- Возвращает второй магический элемент существа
          ---@param creature CreatureID id существа
          ---@return CreatureMagicElementType element элемент
          function(creature)
              errorHook(
              function()
                  Creature.Params.Exception(%creature, "second_element")
              end)
              local answer = MCCS_CREATURE_GENERATED_TABLE[creature] and
                              MCCS_CREATURE_GENERATED_TABLE[creature].second_element or MCCS_CREATURE_GENERATED_TABLE[GetCreatureType(creature)].second_element
              return answer
          end,
  
          Icon =
          --- Возвращает путь к иконке существа
          ---@param creature CreatureID id существа
          ---@return string path путь
          function(creature)
              errorHook(
              function()
                  Creature.Params.Exception(%creature, "icon")
              end)
              local answer = MCCS_CREATURE_GENERATED_TABLE[creature] and
                              MCCS_CREATURE_GENERATED_TABLE[creature].icon.."#xpointer(/Texture)" or MCCS_CREATURE_GENERATED_TABLE[GetCreatureType(creature)].icon.."#xpointer(/Texture)"
              return answer
          end,
  
          Fraction =
          --- Возвращает фракцию существа
          ---@param creature CreatureID id существа
          ---@return CreatureFractionType frac фракция
          function(creature)
              errorHook(
              function()
                  Creature.Params.Exception(%creature, "fraction")
              end)
              local kind = {TOWN_HEAVEN, TOWN_PRESERVE, TOWN_ACADEMY, TOWN_FORTRESS}
              local evil = {TOWN_INFERNO, TOWN_NECROMANCY, TOWN_DUNGEON, TOWN_BASTION}
              local town = Creature.Params.Town(creature)
              local answer = CREATURE_FRAC_NEUTRAL
              if contains(kind, town) then
                  answer = CREATURE_FRAC_KIND
              elseif contains(evil, town) then
                  answer = CREATURE_FRAC_EVIL
              end
              return answer
          end
      },
  
      Component =
      {
          Exception =
          function(creature, component_type, component_id)
              print("<color=red>Creature.Component.Exception: <color=green> creature - ", creature, ", component - ", component_type, ", id - ", component_id)
          end,
  
          HasAbility =
          ---@param creature CreatureID|string id существа или имя стека на поле боя
          ---@param ability integer id умения
          ---@return boolean has имеет умение/нет
          function(creature, ability)
              errorHook(
              function()
                  Creature.Component.Exception(%creature, "ability", %ability)
              end)
              local answer, curr_info = nil, nil
              if not MCCS_CREATURE_GENERATED_TABLE[creature] and not MCCS_CREATURE_GENERATED_TABLE[GetCreatureType(creature)] then
                  return nil
              else
                  curr_info = MCCS_CREATURE_GENERATED_TABLE[creature] and
                              MCCS_CREATURE_GENERATED_TABLE[creature].abilities or
                              MCCS_CREATURE_GENERATED_TABLE[GetCreatureType(creature)].abilities
              end
              --
              if contains(curr_info, ability) then
                  answer = 1
              end
              --
              return answer
          end,
  
          HasSpell =
          --- Проверяет наличие спелла spell у существа creature
          ---@param creature CreatureID|string id существа или имя стека на поле боя
          ---@param spell integer id заклинания
          ---@return boolean имеет спелл/нет.
          function(creature, spell)
              errorHook(
              function()
                  Creature.Component.Exception(%creature, "spell", %spell)
              end)
              local answer, curr_info = nil, nil
              if not MCCS_CREATURE_GENERATED_TABLE[creature] and not MCCS_CREATURE_GENERATED_TABLE[GetCreatureType(creature)] then
                  return nil
              else
                  curr_info = MCCS_CREATURE_GENERATED_TABLE[creature] and
                              MCCS_CREATURE_GENERATED_TABLE[creature].known_spells or
                              MCCS_CREATURE_GENERATED_TABLE[GetCreatureType(creature)].known_spells
              end
              --
              for spell, mastery in curr_info do
                  if spell == _spell then
                  answer = 1
                  break
                  end
              end
              --
              return answer
          end
      },
  
      Type =
      {
          Exception =
          function(creature, type_info)
              print("<color=red>Creature.Type.Exception: <color=green> creature - ", creature, ", type - ", type_info)
          end,
  
          IsUndead =
          --- Является ли существо нежитью
          ---@param creature CreatureID|string id существа или имя стека на поле боя
          ---@return boolean is_undead нежить/нет
          function(creature)
              errorHook(
              function()
                  Creature.Type.Exception(%creature, "undead")
              end)
              local answer = Creature.Component.HasAbility(creature, ABILITY_UNDEAD)
              return answer
          end,
  
          IsElemental =
          --- Является ли существо элементалем
          ---@param creature CreatureID|string id существа или имя стека на поле боя
          ---@return boolean is_elem элементаль/нет
          function(creature)
              errorHook(
              function()
                  Creature.Type.Exception(%creature, "elemental")
              end)
              local answer = Creature.Component.HasAbility(creature, ABILITY_ELEMENTAL)
              return answer
          end,
  
          IsMechanism =
          --- Является ли существо механизмом
          ---@param creature CreatureID|string id существа или имя стека на поле боя
          ---@return boolean is_mech механизм/нет
          function(creature)
              errorHook(
              function()
                  Creature.Type.Exception(%creature, "mechanism")
              end)
              local answer = Creature.Component.HasAbility(creature, ABILITY_MECHANICAL)
              return answer
          end,
  
          IsDemonRaged =
          --- Имеет ли существо гнев крови
          ---@param creature CreatureID|string id существа или имя стека на поле боя
          ---@return boolean is_demon_raged есть гнев/нет
          function(creature)
              errorHook(
              function()
                  Creature.Type.Exception(%creature, "demon raged")
              end)
              local answer = Creature.Component.HasAbility(creature, ABILITY_DEMON_RAGED)
              return answer
          end,
  
          IsAlive =
          --- Является ли существо живым
          ---@param creature CreatureID|string id существа или имя стека на поле боя
          ---@return boolean is_alive живое/нет
          function(creature)
              errorHook(
              function()
                  Creature.Type.Exception(%creature, "alive")
              end)
              local answer = not (Creature.Type.IsUndead(creature) or Creature.Type.IsElemental(creature) or Creature.Type.IsMechanism(creature))
              return answer
          end,
  
          IsShooter =
          --- Является ли существо стрелком
          ---@param creature CreatureID|string id существа или имя стека на поле боя
          ---@return boolean is_shooter стрелок/нет
          function(creature)
              errorHook(
              function()
                  %Creature.Type.Exception(%creature, "shooter")
              end)
              local answer, range  = nil, nil
              if not MCCS_CREATURE_GENERATED_TABLE[creature] and not MCCS_CREATURE_GENERATED_TABLE[GetCreatureType(creature)] then
                  return nil
              else
                  range = MCCS_CREATURE_GENERATED_TABLE[creature] and
                          MCCS_CREATURE_GENERATED_TABLE[creature].range or
                          MCCS_CREATURE_GENERATED_TABLE[GetCreatureType(creature)].range
              end
              answer = range ~= 0 and 1 or nil
              return answer
          end,
  
          IsCaster =
          --- Является ли существо кастером
          ---@param creature CreatureID|string id существа или имя стека на поле боя
          ---@return boolean is_caster кастер/нет
          function(creature)
              errorHook(
              function()
                  Creature.Type.Exception(%creature, "caster")
              end)
              local answer, sp  = nil, nil
              if not MCCS_CREATURE_GENERATED_TABLE[creature] and not MCCS_CREATURE_GENERATED_TABLE[GetCreatureType(creature)] then
                  return nil
              else
                  sp = MCCS_CREATURE_GENERATED_TABLE[creature] and
                          MCCS_CREATURE_GENERATED_TABLE[creature].sp or
                          MCCS_CREATURE_GENERATED_TABLE[GetCreatureType(creature)].sp
              end
              answer = sp ~= 0 and 1 or nil
              return answer
          end,
          
          IsBig =
          --- Является ли существо большим
          ---@param creature CreatureID|string id существа или имя стека на поле боя
          ---@return boolean is_caster кастер/нет
          function(creature)
              errorHook(
              function()
                  Creature.Type.Exception(%creature, "big")
              end)
              local answer, size  = nil, nil
              if not MCCS_CREATURE_GENERATED_TABLE[creature] and not MCCS_CREATURE_GENERATED_TABLE[GetCreatureType(creature)] then
                  return nil
              else
                  size = MCCS_CREATURE_GENERATED_TABLE[creature] and
                          MCCS_CREATURE_GENERATED_TABLE[creature].size or
                          MCCS_CREATURE_GENERATED_TABLE[GetCreatureType(creature)].size
              end
              answer = size == 2 and 1 or nil
              return answer
          end
      },
  
      Sorting =
      {
          Exception =
          function(ex)
              print("<color=red>Creature.Sorting.Exception: <color=green>", ex)
          end,
  
          TownByTier =
          ---@meta
          function(town)
              errorHook(
              function()
                  Creature.Sorting.Exception("TownByTier, town: "..%town)
              end)
              local answer = {[1] = {}, [2] = {}, [3] = {}, [4] = {}, [5] = {}, [6] = {}, [7] = {}}
              for creature, info in MCCS_CREATURE_GENERATED_TABLE do
                  if Creature.Params.Town(creature) == town then
                  local tier = Creature.Params.Tier(creature)
                  answer[tier][length(answer[tier]) + 1] = creature
                  end
              end
              --
              return answer
          end,
  
          Init =
          ---@meta
          function()
              errorHook(
              function()
                  Creature.Sorting.Exception("Init")
              end)
              for town = TOWN_HEAVEN, TOWN_STRONGHOLD do
                  print("<color=red>Creature.Sorting.Init: <color=green>town - ", town)
                  TIER_TABLES[town] = Creature.Sorting.TownByTier(town)
              end
          end,
  
          PairInTown =
          --- Находит парное существо в указанном городе
          ---@param creature CreatureID id существа
          ---@param town TownType город
          ---@return number|nil id id существа
          function(creature, town)
              errorHook(
              function()
                  Creature.Sorting.Exception("PairInTown, creature: "..%creature..", town: "..%town)
              end)
              local town = Creature.Params.Town(creature)
              if town == TOWN_NO_TYPE then
                  return nil
              end
              local tier = Creature.Params.Tier(creature)
              local pos = 0
              for i, check in TIER_TABLES[town][tier] do
                  if check == creature then
                    pos = i
                    break
                  end
              end
              local answer = TIER_TABLES[town][tier][pos]
              return answer
          end
      }
  }