-- main.lua
#include "config.lua"
#include "optimizer/visuals.lua"
#include "optimizer/entities.lua"
#include "optimizer/scripts.lua"
#include "optimizer/physics.lua"
#include "ui.lua"

configOpen = false
lowFpsTimer = 0
fpsRecoveryTimer = 0
lastBoostAlertTime = -10
popupMessage = nil
popupTime = 0

function init()
    InitConfig()

    local currentMap = GetString("game.map")

    if IsCampaignOrScripted() then
        DebugPrint("[TDRX] Detected campaign or scripted gamemode. Restricting optimizations.")
        performanceConfig.removeDebris = false
        performanceConfig.throttleScripts = false
        performanceConfig.reduceLights = false
        performanceConfig.freezeDistantBodies = false
        performanceConfig.suppressFire = false
        SaveConfig()
    elseif IsLaggyMap() then
        DebugPrint("[TDRX] Aggressive optimization enabled for laggy map: " .. currentMap)
        performanceConfig.removeDebris = true
        performanceConfig.reduceLights = true
        performanceConfig.throttleScripts = true
        performanceConfig.disablePostProcessing = true
        performanceConfig.freezeDistantBodies = true
        performanceConfig.suppressFire = true
        SaveConfig()
    end

    OptimizeVisuals()
    -- OptimizeEntities() now runs only when triggered manually
    OptimizeScripts()
    OptimizePhysics()
end

function tick()
    if InputPressed("f10") then
        configOpen = not configOpen
    end

    if configOpen then
        HandleUiInput()
    end

    -- FPS Monitoring
    local timestep = GetTimeStep()
    local fps = 1 / timestep

    if fps < 30 then
        lowFpsTimer = lowFpsTimer + timestep
        fpsRecoveryTimer = 0
    else
        lowFpsTimer = 0
        fpsRecoveryTimer = fpsRecoveryTimer + timestep
    end

    if lowFpsTimer > 2 then
        DebugPrint("[TDRX] Low FPS detected! Activating failsafe performance mode.")
        AutoBoostPerformance()

        -- Show popup only if enabled
        local now = GetTime()
        if performanceConfig.showBoostAlerts then
            if (now - lastBoostAlertTime) > 10 then
                DebugPrint("[TDRX] Boost popup triggered.")
                DisplayPopup("⚠️ Low FPS detected\nPerformance boost applied.")
                lastBoostAlertTime = now
            end
        end

        lowFpsTimer = -9999
    end

    -- Periodic physics refresh
    physicsTimer = (physicsTimer or 0) + timestep
    if physicsTimer > 5 then
        OptimizePhysics()
        physicsTimer = 0
    end
end

function draw()
    if configOpen then
        DrawUI()
    end

    if performanceConfig.showFpsCounter then
        ShowFpsCounter()
    end

    if popupMessage and (GetTime() - popupTime) < 3 then
        UiPush()
            UiFont("regular.ttf", 20)
            UiAlign("left bottom")
            UiTranslate(30, UiHeight() - 40)
            UiColor(1, 1, 1, 0.9)
            UiText(popupMessage)
        UiPop()
    end
end

function AutoBoostPerformance()
    performanceConfig.disablePostProcessing = true
    performanceConfig.reduceLights = true
    performanceConfig.removeDebris = true
    performanceConfig.throttleScripts = true

    OptimizeVisuals()
    OptimizeEntities()
    OptimizeScripts()
    SaveConfig()

    DebugPrint("[TDRX] Performance settings auto-applied due to lag.")
end

function ShowFpsCounter()
    local fps = math.floor(1 / GetTimeStep())
    UiPush()
    UiTranslate(UiWidth() - 120, 20)
    UiFont("bold.ttf", 20)
    UiColor(0.2, 1, 0.2)
    UiText("FPS: " .. fps)
    UiColor(1, 1, 1)
    UiPop()
end

function DisplayPopup(message)
    popupMessage = message
    popupTime = GetTime()
end

function ManualCleanUpDebris()
    local count = OptimizeEntities()

    if count and count > 0 then
        DisplayPopup("🧹 Cleaned up " .. count .. " debris objects.")
    else
        DisplayPopup("✅ No debris found to clean.")
    end
end