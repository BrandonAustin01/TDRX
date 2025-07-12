-- physics.lua
function OptimizePhysics()
    local playerPos = GetPlayerTransform().pos

    -- Freeze distant bodies
    if performanceConfig.freezeDistantBodies then
        local bodies = FindBodies()
        for i = 1, #bodies do
            local body = bodies[i]
            if not HasTag(body, "essential") and not HasTag(body, "do_not_optimize") then
                local dist = VecLength(VecSub(GetBodyCenterOfMass(body), playerPos))

                if dist > 25 then
                    if not HasTag(body, "logic") and not HasTag(body, "vehicle") then
                        SetBodyActive(body, false)
                        SetBodyDynamic(body, false)
                        SetBodySimulationEnabled(body, false)
                        SetTag(body, "frozen_by_boost")
                    end
                elseif HasTag(body, "frozen_by_boost") then
                    SetBodyDynamic(body, true)
                    SetBodySimulationEnabled(body, true)
                    RemoveTag(body, "frozen_by_boost")
                end
            end
        end
    end

    -- Suppress fire on tagged shapes
    if performanceConfig.suppressFire then
        local shapes = FindShapes()
        for i = 1, #shapes do
            local shape = shapes[i]
            if HasTag(shape, "fire") and HasTag(shape, "suppress_fire") then
                RemoveTag(shape, "fire")
                SetTag(shape, "nofire")
            end
        end
    end
end
