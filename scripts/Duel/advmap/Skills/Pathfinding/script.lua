pathfinding =
{
    attack_bonus = 1, 
    def_bonus = 1, 
    heroes_active = {}
}

AddHeroEvent.AddListener("pathfinding_add_hero_event",
function(hero)
    pathfinding.heroes_active[hero] = nil
    startThread(
    function()
        while 1 do
        if IsHeroAlive(%hero) then
            if not pathfinding.heroes_active[%hero] then
                if HasHeroSkill(%hero, PERK_PATHFINDING) then
                    pathfinding.heroes_active[%hero] = 1
                    ChangeHeroStat(%hero, STAT_ATTACK, pathfinding.attack_bonus)
                    ChangeHeroStat(%hero, STAT_DEFENCE, pathfinding.def_bonus)
                end
            else
                if not HasHeroSkill(%hero, PERK_PATHFINDING) then
                    pathfinding.heroes_active[%hero] = nil
                    ChangeHeroStat(%hero, STAT_ATTACK, -pathfinding.attack_bonus)
                    ChangeHeroStat(%hero, STAT_DEFENCE, -pathfinding.def_bonus)
                end
            end
        end
        sleep()
        end
    end)
end)