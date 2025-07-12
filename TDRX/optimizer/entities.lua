-- entities.lua
function OptimizeEntities()
    if not performanceConfig.removeDebris then return end

    local shapes = FindShapes()
    for i = 1, #shapes do
        local shape = shapes[i]
        if HasTag(shape, "debris")
            and not HasTag(shape, "essential")
            and not HasTag(shape, "do_not_optimize") then
            Delete(shape)
        end
    end
end