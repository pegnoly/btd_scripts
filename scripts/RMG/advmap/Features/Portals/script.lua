while not BTD_Portals and BTD_Stacks do
    sleep()
end

CombatResultsEvent.AddListener("BTD_RMG_portals_combat_results",
function(fight_id)
    for stack, info in BTD_Stacks do
        if stack and info and (not IsObjectExists(stack)) then
            local winner = GetSavedCombatArmyHero(fight_id, 1)
            if winner and HasHeroSkill(winner, PERK_SCOUTING) then
                local closest_portal = ""
                local current_closest_distance = math.huge
                for portal, id in BTD_Portals do
                    local x, y, f = GetObjectPosition(portal)
                    local dist1 = x - info.x
                    local dist2 = y - info.y
                    local curr_dist = sqrt(dist1 * dist1 + dist2 * dist2)
                    if curr_dist < current_closest_distance then
                        closest_portal = portal
                        current_closest_distance = curr_dist
                    end
                end
                print("Closest portal ", closest_portal, " is in ", current_closest_distance)
                if current_closest_distance <= 2 then
                    local id = BTD_Portals[closest_portal]
                    for portal, _id in BTD_Portals do
                        if _id == id and portal ~= closest_portal then
                            Object.Show(GetObjectOwner(winner), portal, 1)
                            break
                        end
                    end
                end
            end
            BTD_Stacks[stack] = nil
        end
    end
end)