function OwnerReloadFix()
    for hero, alive in AdvMapHeroesInfo.alive_heroes do
        if hero and alive then
            local owner = GetObjectOwner(hero)..""
            consoleCmd("@SetGameVar('"..hero.."_owner', "..owner..")")
        end
    end
end

consoleCmd("@MapReloadEvent.AddListener('BTD_RMG_reload_hero_owners', OwnerReloadFix)")