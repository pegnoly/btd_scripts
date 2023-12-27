maahir_duel = {
    heroes = {"Maahir", "Maahir1", "Maahir2"},
    resources = {[0] = 50; 50, 30, 30, 30, 30}
}

while not artificier_duel do
    sleep()
end

MapLoadingEvent.AddListener("BTD_duel_maahir_spec_init",
function()
    for _, hero in maahir_duel.heroes do
        artificier_duel.CustomDistribution[hero] = function(hero)
            for res, count in maahir_duel.resources do
                Resource.Change(hero, res, count)
            end
        end
    end
end)

