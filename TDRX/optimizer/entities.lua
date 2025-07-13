function OptimizeEntities()
    if not performanceConfig.removeDebris then return 0 end

    local playerPos = GetPlayerTransform().pos
    local cleanupRadius = 50  -- how far from player debris is considered
    local massThreshold = 40  -- increase from 20 to remove slightly heavier pieces
    local sizeThreshold = 3   -- increase from 2.5 to include larger chunks
    local minDistance = 2     -- avoid deleting things too close to player
    local removed = 0

    -- Build bounding box around player
    local min = VecSub(playerPos, Vec(cleanupRadius, cleanupRadius, cleanupRadius))
    local max = VecAdd(playerPos, Vec(cleanupRadius, cleanupRadius, cleanupRadius))

    QueryRequire("physical dynamic")
    local shapes = QueryAabbShapes(min, max)

    for i = 1, #shapes do
        local shape = shapes[i]
        local body = GetShapeBody(shape)

        -- Skip protected entities
        local isProtected = 
            HasTag(shape, "essential") or
            HasTag(shape, "do_not_optimize") or
            HasTag(body, "essential") or
            HasTag(body, "do_not_optimize") or
            body == GetToolBody()

        if not isProtected then
            local mass = GetBodyMass(body)
            local minB, maxB = GetShapeBounds(shape)
            local size = VecLength(VecSub(maxB, minB))

            -- Check distance to player (avoid removing things in your face)
            local dist = VecLength(VecSub(GetShapeWorldTransform(shape).pos, playerPos))

            if mass < massThreshold and size < sizeThreshold and dist > minDistance then
                Delete(shape)
                removed = removed + 1
            end
        end
    end

    return removed
end

-- Helper for shape size (approximate bounding volume)
function GetShapeBoundsSize(shape)
    local min, max = GetShapeBounds(shape)
    local sizeVec = VecSub(max, min)
    return VecLength(sizeVec)
end
