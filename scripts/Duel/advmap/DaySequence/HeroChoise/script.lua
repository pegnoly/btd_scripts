-----------------------------------
-- Второй день - пикобаны героев --

BTD_HeroPick = 
{
    hero_pool = 
    {
        [TOWN_HEAVEN] = {
            'Ving', 
            'Sarge', 
            'Christian', 
            'Orrin', 
            'Mardigo', 
            'Maeve', 
            'Brem', 
            'Nathaniel', 
            'Godric', 
            'Isabel' -- 4.6; [+50% к тренируемым]
            },
        [TOWN_INFERNO] = {
            'Efion', 
            'Grok', 
            'Calid', 
            'Oddrema', 
            'Deleb', 
            'Marder', 
            'Jazaz',
            'Nymus', 
            'Biara',
            'Orlando' -- 4.6; [из рмг] 
            },
        [TOWN_PRESERVE] = {
            'Metlirn', 
            'Linaas', 
            'Elleshar', 
            'Gillion', 
            'Diraya', 
            'Itil', 
            'Ossir', 
            'Nadaur', 
            'Heam',
            'Ildar', -- 4.6; [из рмг]
            },
        [TOWN_NECROMANCY] = {
            'Pelt', 
            'Nemor', 
            'Aberrar', 
            'Gles', 
            'Tamika', 
            'Muscip', 
            'Straker', 
            'Effig', 
            'Berein', 
            'Arantir', -- 4.6; [дефолт спеца, аватара из рмг]
            },
        [TOWN_DUNGEON] = {
            'Ohtarig', 
            'Urunir', 
            'Almegir', 
            'Menel', 
            'Dalom', 
            'Inagost', 
            'Ferigl', 
            'Eruina', 
            'Kelodin',
            'Railag' -- 4.6; [дефолт спеца, см. рмг]
            },
        [TOWN_ACADEMY] = {
            'Tan', 
            'Nur', 
            'Razzak', 
            'Astral', 
            'Sufi', 
            'Isher', 
            'Faiz', 
            'Havez', 
            'Maahir', 
            'Zehir' -- 4.6; [дефолт]
            },
        [TOWN_FORTRESS] = {
            'Brand', 
            'Bersy', 
            'Una', 
            'Ingvar', 
            'Skeggy', 
            'Vegeyr', 
            'Ottar', 
            'Egil', 
            'Wulfstan', 
            'Rolf' -- 4.6; [+хп юнитам за уровень]
            },
        [TOWN_STRONGHOLD] = {
            'Hero2', 
            'Hero3', 
            'Hero4', 
            'Hero9', 
            'Hero1', 
            'Hero8', 
            'Hero7', 
            'Hero6', 
            'Gottai', 
            'Kujin' -- 4.6; [стартует со всеми кличами]
            },
    },

    current_heroes_for_player = {
        [PLAYER_1] = {},
        [PLAYER_2] = {}
    }
}

-- диалог бана героев
ban_heroes_dialog = {
    state = 1,
    icon = '/UI/MPDMWait/TripleHeroesView/CustomHeroBig.xdb#xpointer(/Texture)',
    path = GetMapDataPath()..'Duel/Cherk/',
    title = 'Cherk',
  
    perform_func = function(pl, curr_state, answer, next_state)
        --print(heroesList[3-pl])
        --print('Игрок ', pl, ' забанил оппоненту героя ', heroesList[3-pl][next_state])
        if next_state + 0 < 0 then
            return 0
        else
            RemoveObject(BTD_HeroPick.current_heroes_for_player[3 - pl][next_state])
            if not Dialog.GetActiveDialogForPlayer(pl) then
                startThread(ShowFlyingSign, GetMapDataPath()..'Duel/Cherk/Wait.txt')
            end
            local main = GetPlayerHeroes(pl)[0]
            startThread(
            function()
                while not (GetCurrentPlayer() == -1) and not IsPlayerCurrent(%pl) do
                    sleep()
                end
                while length(GetPlayerHeroes(%pl))>=3 do
                    sleep()
                end
                Dialog.NewDialog(choose_heroes_dialog, %main, %pl)
            end)
            return 0
        end
    end,
    
    select_text = '',
    options =
    {
        [1]= {[0] = GetMapDataPath()..'Duel/Cherk/BanHero.txt'},
    },
    
    Open = function(pl)
        for i, option in Dialog.GetActiveDialogForPlayer(pl).options[1] do
            if i > 0 then
                option = nil
            end
        end
        print(BTD_HeroPick.current_heroes_for_player[3 - pl])
        for n, hero in BTD_HeroPick.current_heroes_for_player[3 - pl] do -- 3-player вернёт номер оппонента
            --print('Игрок: ', pl, '; нашёл для бана героя: ', hero, ' (', n, ')')
            Dialog.SetAnswer(Dialog.GetActiveDialogForPlayer(pl), 1, n+1, Hero.Params.Name(hero), n, 1, 1)
        end
        Dialog.Action(pl)
    end,
}

-- диалог выбора героя
choose_heroes_dialog = {
    state = 1,
    icon = '/UI/MPDMWait/TripleHeroesView/CustomHeroBig.xdb#xpointer(/Texture)',
    path = GetMapDataPath()..'Duel/Cherk/',
    title = 'Cherk',
    select_text = '',
    options = {[1]={[0] = GetMapDataPath()..'Duel/Cherk/ChooseHero.txt',}},
  
    perform_func = 
    function(pl, curr_state, answer, next_state)
        --print('Игрок ', pl, ' выбрал себе героя ', heroesList[pl][next_state])
        if next_state then
            for n, hero in BTD_HeroPick.current_heroes_for_player[pl] do
                if n ~= next_state then
                    RemoveObject(hero)
                end
            end
            -- Автоинтерактив оставшегося героя со всеми пассами
            local hero = GetPlayerHeroes(pl)[0]
            while GetPlayerHeroes(pl)[1] do 
                sleep() 
            end
            
            if GetPlayerRace(pl) ~= TOWN_STRONGHOLD then
                for n, shrine in playerShrines[pl] do
                    Trigger(OBJECT_TOUCH_TRIGGER, shrine, nil)
                    MakeHeroInteractWithObject(hero, shrine)
                    Trigger(OBJECT_TOUCH_TRIGGER, shrine, 'ShrinesAutoVisit')
                end
            end;
            

            local func = function() return 1 end
            startThread(UnlimMove, hero, func)
            return 0
        end
    end,
  
    Open = function(pl)
        heroesList[pl] = GetPlayerHeroes(pl)
        for i, option in Dialog.GetActiveDialogForPlayer(pl).options[1] do
            if i > 0 then
                option = nil
            end
        end
        for n, hero in heroesList[pl] do
            Dialog.SetAnswer(Dialog.GetActiveDialogForPlayer(pl), 1, n+1, Hero.Params.Name(hero), n, 1, 1)
        end
        Dialog.Action(pl)
    end,
}

-- пикобан в ивенте нового дня
NewDayEvent.AddListener("BTD_duel_hero_pick_listener",
function(day)
    if day == BTD_HERO_CHOISE_DAY then
        local deploy_coords = {[2]={[1]={23,35}, [2]={25,36}, [3]={25,34},},
                               [1]={[1]={134,47}, [2]={136,48}, [3]={136,46},}}
        for pl=1, 2 do
            local race = GetPlayerRace(pl)
            local heroes = BTD_HeroPick.hero_pool[race]
            for i=1, 3 do
                local hc = length(heroes)
                repeat
                    hero = heroes[random(hc)+1]
                until not IsObjectExists(hero..'1') and not IsObjectExists(hero..'2')
                hero = hero..pl
                local x, y, fl = deploy_coords[pl][i][1], deploy_coords[pl][i][2], 0
                DeployReserveHero(hero, x, y, fl)
                while not IsObjectExists(hero) do 
                    sleep() 
                end
                startThread(
                function(hero)
                    for creature = 1, CREATURES_COUNT - 1 do
                        RemoveHeroCreatures(hero, creature, 9999)
                    end
                end, hero)
            end
            --
            heroesList = {[1] = GetPlayerHeroes(1),
                            [2] = GetPlayerHeroes(2),}
            local main = BTD_HeroPick.current_heroes_for_player[pl][0]
        
            startThread(
            function(pl)
                local id = Art.Distribution.RandomMinor()
                for n, hero in BTD_HeroPick.current_heroes_for_player[pl] do
                    GiveArtefact(hero, id)
                end
            end, pl)
            startThread(
            function()
                while not (GetCurrentPlayer() == -1) and not IsPlayerCurrent(%pl) do
                    sleep()
                end
                Dialog.NewDialog(ban_heroes_dialog, %main, %pl)
            end)
        end
    end    
end)