-- visuals.lua
function OptimizeVisuals()
    if performanceConfig.disablePostProcessing then
        -- No direct Lua API to disable post-processing. Placeholder.
        -- DebugPrint("[TDRX] Post-processing cannot be disabled programmatically.")
    end

    if performanceConfig.reduceLights then
        local lights = FindLights()
        for i = 1, #lights do
            local light = lights[i]
            if not HasTag(light, "essential") and not HasTag(light, "do_not_optimize") then
                SetLightEnabled(light, false)
            end
        end
    end
end
