-- config.lua
#include "json.lua"

performanceConfig = {
    disablePostProcessing = true,
    reduceLights = true,
    removeDebris = true,
    limitParticles = true,
    throttleScripts = true,
    freezeDistantBodies = true,
    suppressFire = true,
    showFpsCounter = true
}

function InitConfig()
    local saved = GetString("savegame.mod.tdrx.config")
    if saved ~= "" then
        local ok, loaded = pcall(json.decode, saved)  -- ✅ use json.decode
        if ok and type(loaded) == "table" then
            for k, v in pairs(loaded) do
                performanceConfig[k] = v
            end
        end
    end
end

function SaveConfig()
    local jsonStr = json.encode(performanceConfig)  -- ✅ works now
    SetString("savegame.mod.tdrx.config", jsonStr)
end

function LoadConfig()
    local saved = GetString("savegame.mod.tdrx.config")
    if saved ~= "" then
        local ok, decoded = pcall(json.decode, saved)
        if ok and type(decoded) == "table" then
            performanceConfig = decoded
        end
    end
end

knownLaggyMaps = {
    ["mansion.lagfest"] = true,
    ["castle_redux"] = true,
    ["warehouse_heavy"] = true
}

function IsLaggyMap()
    local mapName = GetString("game.map")
    return knownLaggyMaps[mapName] == true
end

function ApplyPreset(preset)
    if preset == "ultra" then
        performanceConfig.disablePostProcessing = true
        performanceConfig.reduceLights = true
        performanceConfig.removeDebris = true
        performanceConfig.limitParticles = true
        performanceConfig.throttleScripts = true
        performanceConfig.freezeDistantBodies = true
        performanceConfig.suppressFire = true
        performanceConfig.showFpsCounter = true

    elseif preset == "balanced" then
        performanceConfig.disablePostProcessing = true
        performanceConfig.reduceLights = true
        performanceConfig.removeDebris = false
        performanceConfig.limitParticles = false
        performanceConfig.throttleScripts = true
        performanceConfig.freezeDistantBodies = true
        performanceConfig.suppressFire = true
        performanceConfig.showFpsCounter = true

    elseif preset == "quality" then
        performanceConfig.disablePostProcessing = false
        performanceConfig.reduceLights = false
        performanceConfig.removeDebris = false
        performanceConfig.limitParticles = false
        performanceConfig.throttleScripts = false
        performanceConfig.freezeDistantBodies = false
        performanceConfig.suppressFire = false
        performanceConfig.showFpsCounter = false
    end

    SaveConfig()
    OptimizeVisuals()
    OptimizeEntities()
    OptimizeScripts()
    OptimizePhysics()
end

function IsCampaignOrScripted()
    local map = GetString("game.map")
    return
        string.find(map, "campaign") or
        string.find(map, "heist") or
        string.find(map, "villa") or
        HasTag(GetWorldBody(), "gamemode") or
        HasTag(GetWorldBody(), "mission")
end
