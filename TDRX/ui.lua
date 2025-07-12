-- ui.lua (patched with keyboard navigation + reset button)
local options = {
    { key = "removeDebris", label = "Remove Debris", hint = "Disables clutter and debris" },
    { key = "reduceLights", label = "Reduce Lights", hint = "Lowers dynamic light count" },
    { key = "throttleScripts", label = "Throttle Scripts", hint = "Limits script activity" },
    { key = "disablePostProcessing", label = "Disable Post-Processing", hint = "Disables screen effects" },
    { key = "freezeDistantBodies", label = "Freeze Distant Bodies", hint = "Freezes objects far from player" },
    { key = "suppressFire", label = "Suppress Fire Effects", hint = "Stops fire from spreading or rendering" },
    { key = "showBoostAlerts", label = "Show Boost Alerts", hint = "Toggle popup when lag is detected" },
    { key = "showFpsCounter", label = "Show FPS Counter", hint = "Displays FPS in corner" },
}

local selectedIndex = 1

TDRX_VERSION = "1.0.0" -- change this as needed

function DrawUI()
    UiPush()
    UiTranslate(50, 50)
    UiFont("regular.ttf", 20)
    UiText("TDRX (v" .. TDRX_VERSION .. ")")
    UiTranslate(0, 30)

    for i, opt in ipairs(options) do
        if i == selectedIndex then
            UiColor(1, 1, 0.4)
            UiText("▶ " .. opt.label .. (performanceConfig[opt.key] and " [✓]" or " [ ]"))
            UiColor(1, 1, 1)
        else
            UiText("    " .. opt.label .. (performanceConfig[opt.key] and " [✓]" or " [ ]"))
        end
        UiTranslate(0, 30)
    end

    -- Reset button
    UiColor(1, 0.6, 0.6)
    UiFont("bold.ttf", 20)
    if selectedIndex == #options + 1 then
        UiText("▶ Reset to Defaults")
    else
        UiText("   Reset to Defaults")
    end
    UiColor(1, 1, 1)

    UiTranslate(0, 20)
    UiColor(0.7, 0.7, 1)
    UiText("Press ENTER to toggle | Z/X to navigate")
    
    UiPop()
end

function HandleUiInput()
    if InputPressed("z") then
        selectedIndex = selectedIndex - 1
        if selectedIndex < 1 then selectedIndex = #options + 1 end

    elseif InputPressed("x") then
        selectedIndex = selectedIndex + 1
        if selectedIndex > #options + 1 then selectedIndex = 1 end

    elseif InputPressed("return") then
        if selectedIndex <= #options then
            local opt = options[selectedIndex]
            performanceConfig[opt.key] = not performanceConfig[opt.key]
            SaveConfig()
        elseif selectedIndex == #options + 1 then
            ResetToDefaults()
        end
    end
end

function ResetToDefaults()
    performanceConfig.removeDebris = true
    performanceConfig.reduceLights = true
    performanceConfig.throttleScripts = true
    performanceConfig.disablePostProcessing = false
    performanceConfig.freezeDistantBodies = false
    performanceConfig.suppressFire = false
    performanceConfig.showFpsCounter = false
    performanceConfig.showBoostAlerts = true
    SaveConfig()
end
