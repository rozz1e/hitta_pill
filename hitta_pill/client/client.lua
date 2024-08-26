ESX = exports["es_extended"]:getSharedObject()

RegisterNetEvent('hitta_pill:takePill')
AddEventHandler('hitta_pill:takePill', function()
    drugEffect()
    Wait(6000)
    TriggerEvent('hitta_pill:takeToCoords')
    Wait(13000)
    resetEffects()
end)

resetEffects = function()
    local playerPed = PlayerPedId()
    local playerId = PlayerId()

    SetPedMotionBlur(playerPed, false)
    ShakeGameplayCam('DRUNK_SHAKE', 0.0)
    SetTimecycleModifierStrength(0.0)
    AnimpostfxStopAll()
    SetPedMoveRateOverride(playerId, 1.0)
    SetRunSprintMultiplierForPlayer(playerId, 1.0)
    Wait(5000)
    ResetPedMovementClipset(playerPed)
end

RegisterNetEvent('hitta_pill:takeToCoords')
AddEventHandler('hitta_pill:takeToCoords', function()
    local random = math.random(1, #Config.Points)
    TeleportLocation = {
        x = Config.Points[random][1],
        y = Config.Points[random][2],
        z = Config.Points[random][3],
        h = Config.Points[random][4]
    }

    teleportPlayer(TeleportLocation)
end)

pillAnim = function()
    loadAnimDict('mp_suicide')
    TaskPlayAnim(PlayerPedId(), 'mp_suicide', 'pill', 3.0, 3.0, 2000, 48, 0, false, false, false)
end

drugEffect = function()
    local playerPed = PlayerPedId()
    local playerId = PlayerId()

    pillAnim()
    Wait(5000)

    loadAnimSet('MOVE_M@DRUNK@VERYDRUNK')
    SetPedMovementClipset(playerPed, 'MOVE_M@DRUNK@VERYDRUNK', true)
    Wait(5000)

    ClearPedTasksImmediately(playerPed)
    SetPedMoveRateOverride(playerId, 10.0)
    SetRunSprintMultiplierForPlayer(playerId, 0.6)
    SetPedMotionBlur(playerPed, true)
    SetTimecycleModifier('spectator5')
    AnimpostfxPlay('DrugsMichaelAliensFight', 10000001, true)
    ShakeGameplayCam('DRUNK_SHAKE', 3.5)
    Wait(10000)

    SetPedToRagdoll(playerPed, 10000, 10000, 0, 0, 0, 0)
end

teleportPlayer = function(pos)
    local playerPed = PlayerPedId()
    
    DoScreenFadeOut(200)
    Wait(200)
    SetEntityCoords(playerPed, pos.x, pos.y, pos.z, 0, 0, 0, false)
    SetEntityHeading(playerPed, pos.h)
    PlaceObjectOnGroundProperly(playerPed)
    SetPedToRagdoll(playerPed, 5000, 5000, 0, 0, 0, 0)
    ESX.ShowNotification(Config.Text)
    Wait(1500)
    DoScreenFadeIn(200)
end

loadAnimDict = function(dict)
    RequestAnimDict(dict)
    while not HasAnimDictLoaded(dict) do
        Wait(500)
    end
end

loadAnimSet = function(set)
    RequestAnimSet(set)
    while not HasAnimSetLoaded(set) do
      Wait(0)
    end
end