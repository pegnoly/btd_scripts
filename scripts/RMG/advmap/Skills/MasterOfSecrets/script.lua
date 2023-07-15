master_of_secrets = {
    active_for_hero = {}
}

AddHeroEvent.AddListener("BTD_RMG_master_of_secrets_add_hero",
function(hero)
    master_of_secrets.active_for_hero[hero] = nil
    startThread(
    function ()
        while 1 do
            if IsHeroAlive(%hero) then
                if not master_of_secrets.active_for_hero[%hero] then
                    if HasHeroSkill(%hero, DEMON_FEAT_MASTER_OF_SECRETS) then
                        master_of_secrets.active_for_hero[%hero] = 1
                        Art.Distribution.Give(%hero, ARTIFACT_SCROLL_OF_SPELL_X)
                        return
                    end
                end
            end
            sleep()
        end
    end)
end)