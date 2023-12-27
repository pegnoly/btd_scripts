while not BTD_NewObjects do
    sleep()
end

function DwarvenMine_Test()
    for obj, type in BTD_NewObjects do
        if type == BTD_DWARVEN_MINE then
            Object.Show(1, obj)
        end
    end
end