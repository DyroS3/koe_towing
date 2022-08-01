----Gets ESX-------------------------------------------------------------------------------------------------------------------------------
ESX = nil

Citizen.CreateThread(function()
    while ESX == nil do
        TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
        Citizen.Wait(0)
    end
end)

AddEventHandler('onResourceStart', function(resourceName)
	if (resourceName == GetCurrentResourceName()) then
        while (ESX == nil) do Citizen.Wait(100) end        
        Citizen.Wait(5000)
        ESX.PlayerLoaded = true
	end
end)
---------------------------------------------------------------------------------------------------------------------------------------
local onJob = false
local inZone = false

local colorNames = {
    ['0'] = "Metallic Black",
    ['1'] = "Metallic Graphite Black",
    ['2'] = "Metallic Black Steal",
    ['3'] = "Metallic Dark Silver",
    ['4'] = "Metallic Silver",
    ['5'] = "Metallic Blue Silver",
    ['6'] = "Metallic Steel Gray",
    ['7'] = "Metallic Shadow Silver",
    ['8'] = "Metallic Stone Silver",
    ['9'] = "Metallic Midnight Silver",
    ['10'] = "Metallic Gun Metal",
    ['11'] = "Metallic Anthracite Grey",
    ['12'] = "Matte Black",
    ['13'] = "Matte Gray",
    ['14'] = "Matte Light Grey",
    ['15'] = "Util Black",
    ['16'] = "Util Black Poly",
    ['17'] = "Util Dark silver",
    ['18'] = "Util Silver",
    ['19'] = "Util Gun Metal",
    ['20'] = "Util Shadow Silver",
    ['21'] = "Worn Black",
    ['22'] = "Worn Graphite",
    ['23'] = "Worn Silver Grey",
    ['24'] = "Worn Silver",
    ['25'] = "Worn Blue Silver",
    ['26'] = "Worn Shadow Silver",
    ['27'] = "Metallic Red",
    ['28'] = "Metallic Torino Red",
    ['29'] = "Metallic Formula Red",
    ['30'] = "Metallic Blaze Red",
    ['31'] = "Metallic Graceful Red",
    ['32'] = "Metallic Garnet Red",
    ['33'] = "Metallic Desert Red",
    ['34'] = "Metallic Cabernet Red",
    ['35'] = "Metallic Candy Red",
    ['36'] = "Metallic Sunrise Orange",
    ['37'] = "Metallic Classic Gold",
    ['38'] = "Metallic Orange",
    ['39'] = "Matte Red",
    ['40'] = "Matte Dark Red",
    ['41'] = "Matte Orange",
    ['42'] = "Matte Yellow",
    ['43'] = "Util Red",
    ['44'] = "Util Bright Red",
    ['45'] = "Util Garnet Red",
    ['46'] = "Worn Red",
    ['47'] = "Worn Golden Red",
    ['48'] = "Worn Dark Red",
    ['49'] = "Metallic Dark Green",
    ['50'] = "Metallic Racing Green",
    ['51'] = "Metallic Sea Green",
    ['52'] = "Metallic Olive Green",
    ['53'] = "Metallic Green",
    ['54'] = "Metallic Gasoline Blue Green",
    ['55'] = "Matte Lime Green",
    ['56'] = "Util Dark Green",
    ['57'] = "Util Green",
    ['58'] = "Worn Dark Green",
    ['59'] = "Worn Green",
    ['60'] = "Worn Sea Wash",
    ['61'] = "Metallic Midnight Blue",
    ['62'] = "Metallic Dark Blue",
    ['63'] = "Metallic Saxony Blue",
    ['64'] = "Metallic Blue",
    ['65'] = "Metallic Mariner Blue",
    ['66'] = "Metallic Harbor Blue",
    ['67'] = "Metallic Diamond Blue",
    ['68'] = "Metallic Surf Blue",
    ['69'] = "Metallic Nautical Blue",
    ['70'] = "Metallic Bright Blue",
    ['71'] = "Metallic Purple Blue",
    ['72'] = "Metallic Spinnaker Blue",
    ['73'] = "Metallic Ultra Blue",
    ['74'] = "Metallic Bright Blue",
    ['75'] = "Util Dark Blue",
    ['76'] = "Util Midnight Blue",
    ['77'] = "Util Blue",
    ['78'] = "Util Sea Foam Blue",
    ['79'] = "Uil Lightning blue",
    ['80'] = "Util Maui Blue Poly",
    ['81'] = "Util Bright Blue",
    ['82'] = "Matte Dark Blue",
    ['83'] = "Matte Blue",
    ['84'] = "Matte Midnight Blue",
    ['85'] = "Worn Dark blue",
    ['86'] = "Worn Blue",
    ['87'] = "Worn Light blue",
    ['88'] = "Metallic Taxi Yellow",
    ['89'] = "Metallic Race Yellow",
    ['90'] = "Metallic Bronze",
    ['91'] = "Metallic Yellow Bird",
    ['92'] = "Metallic Lime",
    ['93'] = "Metallic Champagne",
    ['94'] = "Metallic Pueblo Beige",
    ['95'] = "Metallic Dark Ivory",
    ['96'] = "Metallic Choco Brown",
    ['97'] = "Metallic Golden Brown",
    ['98'] = "Metallic Light Brown",
    ['99'] = "Metallic Straw Beige",
    ['100'] = "Metallic Moss Brown",
    ['101'] = "Metallic Biston Brown",
    ['102'] = "Metallic Beechwood",
    ['103'] = "Metallic Dark Beechwood",
    ['104'] = "Metallic Choco Orange",
    ['105'] = "Metallic Beach Sand",
    ['106'] = "Metallic Sun Bleeched Sand",
    ['107'] = "Metallic Cream",
    ['108'] = "Util Brown",
    ['109'] = "Util Medium Brown",
    ['110'] = "Util Light Brown",
    ['111'] = "Metallic White",
    ['112'] = "Metallic Frost White",
    ['113'] = "Worn Honey Beige",
    ['114'] = "Worn Brown",
    ['115'] = "Worn Dark Brown",
    ['116'] = "Worn straw beige",
    ['117'] = "Brushed Steel",
    ['118'] = "Brushed Black steel",
    ['119'] = "Brushed Aluminium",
    ['120'] = "Chrome",
    ['121'] = "Worn Off White",
    ['122'] = "Util Off White",
    ['123'] = "Worn Orange",
    ['124'] = "Worn Light Orange",
    ['125'] = "Metallic Securicor Green",
    ['126'] = "Worn Taxi Yellow",
    ['127'] = "police car blue",
    ['128'] = "Matte Green",
    ['129'] = "Matte Brown",
    ['130'] = "Worn Orange",
    ['131'] = "Matte White",
    ['132'] = "Worn White",
    ['133'] = "Worn Olive Army Green",
    ['134'] = "Pure White",
    ['135'] = "Hot Pink",
    ['136'] = "Salmon pink",
    ['137'] = "Metallic Vermillion Pink",
    ['138'] = "Orange",
    ['139'] = "Green",
    ['140'] = "Blue",
    ['141'] = "Mettalic Black Blue",
    ['142'] = "Metallic Black Purple",
    ['143'] = "Metallic Black Red",
    ['144'] = "hunter green",
    ['145'] = "Metallic Purple",
    ['146'] = "Metaillic V Dark Blue",
    ['147'] = "MODSHOP BLACK1",
    ['148'] = "Matte Purple",
    ['149'] = "Matte Dark Purple",
    ['150'] = "Metallic Lava Red",
    ['151'] = "Matte Forest Green",
    ['152'] = "Matte Olive Drab",
    ['153'] = "Matte Desert Brown",
    ['154'] = "Matte Desert Tan",
    ['155'] = "Matte Foilage Green",
    ['156'] = "DEFAULT ALLOY COLOR",
    ['157'] = "Epsilon Blue",
}

exports.qtarget:AddTargetBone({'bonnet'},{
	options = {
		{
			event = "koe_towing:getVehicleInfo",
			icon = "fa-solid fa-car",
			label = "Tow Menu",
            job = {['police'] = 1}
		},
	},
	distance = 2
})

RegisterNetEvent('koe_towing:getVehicleInfo')
AddEventHandler('koe_towing:getVehicleInfo', function()
    local playerPed = PlayerPedId()
    local playerCoords = GetEntityCoords(playerPed)
    local targetVehicle = GetClosestVehicle(playerCoords, 3.0, 0 , 70)
    local targetPlate = GetVehicleNumberPlateText(targetVehicle)
    local targetHash = GetEntityModel(targetVehicle)
    local targetDisplayName = GetDisplayNameFromVehicleModel(targetHash)
    local targetModel = GetLabelText(targetDisplayName)
    local primaryColor = GetVehicleColours(targetVehicle)
    primaryColor = colorNames[tostring(primaryColor)]

    TriggerServerEvent('koe_towing:checkOwned', targetPlate, owned, targetModel, primaryColor, playerCoords)

    
end)

RegisterNetEvent('koe_towing:menu')
AddEventHandler('koe_towing:menu', function(targetPlate, owned, targetModel, primaryColor, playerCoords)
    if owned == false then
        owned = 'False'
    else
        owned = 'True'
    end

    lib.registerContext({
        id = 'towmenu',
        title = 'Vehicle Information',
        options = {
            {
                title = 'Vehicle Information',
                menu = 'vehinfo',
                arrow = true,
            },
            {
                title = 'Mark for Towing',
                description = 'Mark the vehicle for towing.',
                event = 'koe_towing:markForTowing',
                args = {
                    location = playerCoords,
                    plate = targetPlate,
                    owned = owned,
                    model = targetModel,
                    color = primaryColor,
                }
            },
            {
                title = 'City Impound',
                description = 'The Player will have to pay to return the vehicle.',
                event = 'koe_towing:cityImpound'
            },
        },
        {
            id = 'vehinfo',
            title = 'Vehicle Information',
            menu = 'towmenu',
            options = {
                {
                    title = 'Model',
                    description = targetModel
                },
                {
                    title = 'Plate',
                    description = targetPlate
                },
                {
                    title = 'Color',
                    description = primaryColor
                },
                {
                    title = 'Owned',
                    description = owned
                },
            }
        }
    })
    lib.showContext('towmenu')
 
end)

RegisterNetEvent('koe_towing:cityImpound')
AddEventHandler('koe_towing:cityImpound', function(targetPlate, owned, targetModel, primaryColor)
    ExecuteCommand('impound')
end)

RegisterNetEvent('koe_towing:markForTowing')
AddEventHandler('koe_towing:markForTowing', function(data)

    local location = data.location
    local x = data.location.x
    local y = data.location.y
    local z = data.location.z
    local plate = data.plate
    local owned = data.owned
    local model = data.model
    local color = data.color

    if lib.progressBar({
        duration = 1000,
        label = 'Marking this vehicle for tow',
        useWhileDead = false,
        canCancel = true,
        disable = {
            car = true,
            move = true,
        },
        anim = {
            dict = 'amb@code_human_wander_clipboard@male@idle_a',
            clip = 'idle_a' 
        },
        prop = {
            model = `prop_fib_clipboard`,
            pos = vec3(0.03, 0.03, 0.02),
            rot = vec3(0.0, 0.0, -1.5) 
        },
    })  then 
            TriggerServerEvent('koe_towing:marked', location, plate, owned, model, color, x, y, z)
        else 
            lib.notify({
                title = 'Tow',
                description = 'You canceled the mark.',
                type = 'error',
                duration = 8000,
                position = 'top'
            })
        end
end)

exports.qtarget:AddBoxZone('towing', vector3(-192.52, -1162.68, 23.67), 1.0, 4, {
    name="towing",
    heading=270,
    --debugPoly=true,
    minZ=19.87,
    maxZ=23.87
    }, {
        options = {
            {
                event = "koe_towing:getTowsClient",
                icon = "fa-solid fa-car",
                label = "Tow Menu",
                job = 'towing',
            },
        },
        distance = 3.5
})

RegisterNetEvent('koe_towing:getTowsClient')
AddEventHandler('koe_towing:getTowsClient', function(data)
    TriggerServerEvent('koe_towing:getTows')
end)

RegisterNetEvent('koe_towing:towsMenu')
AddEventHandler('koe_towing:towsMenu', function(result)
    local options = {{title = 'Hover over a selection for more info'}}
    
    for k, v in pairs(result) do
        table.insert(options,
            {
                title = 'Plate', 
                description = v.plate, 
                args = {selectedPlate = v.plate, selectedCoords = v.coords, selectedOwned = v.owned, selectedModel = v.model, selectedColor = v.color, payout = v.price, x = v.x, y = v.y, z = v.z},
                event = 'koe_towing:contractMenu',
                arrow = true,
                metadata = {
                    {label = 'Payout', value = v.price},
                    {label = 'Owned', value = v.owned},
                    {label = 'Model', value = v.model},
                    {label = 'Color', value = v.color},
                }
            }
        )
    end

    lib.registerContext({
        id = 'towmenu2',
        title = 'Tow Menu',
        options = {
            {
                title = 'Available Tows',
                menu = 'cars',
                arrow = true,
            },
            lib.registerContext({
                id = 'cars',
                title = 'Cars to Tow',
                menu = 'towmenu2',
                options = options
            })
        }
    })
        lib.showContext('towmenu2')

end)

RegisterNetEvent('koe_towing:contractMenu')
AddEventHandler('koe_towing:contractMenu', function(data)

    lib.registerContext({
        id = 'contractMenu',
        title = 'Conctract Options',
        menu = 'cars',
        options = {
            {
                title = 'Accept Contract',
                arrow = true,
                event = 'koe_towing:selectedTow',
                args = {selectedPlate = data.selectedPlate, selectedCoords = data.selectedCoords, selectedOwned = data.selectedOwned, selectedModel = data.selectedModel, selectedColor = data.selectedColor, payout = data.payout, coords = data.coords, x = data.x, y = data.y, z = data.z},
            },
            {
                title = 'Remove Contract',
                arrow = true,
                event = 'koe_towing:remove',
                args = {selectedPlate = data.selectedPlate, selectedCoords = data.selectedCoords, selectedOwned = data.selectedOwned, selectedModel = data.selectedModel, selectedColor = data.selectedColor, payout = data.payout, coords = data.coords, x = data.x, y = data.y, z = data.z},
            },
        }
    })
        lib.showContext('contractMenu')
end)

RegisterNetEvent('koe_towing:remove')
AddEventHandler('koe_towing:remove', function(data)
    local plateToRemove = data.selectedPlate

    if lib.progressBar({
        duration = 3000,
        label = 'Press X to Cancel',
        useWhileDead = false,
        canCancel = true,
        disable = {
            car = true,
            move = true,
        },
    })  then 
            TriggerServerEvent('koe_towing:removeContract', plateToRemove)
            lib.notify({
                title = 'Tow',
                description = 'Contract Removed.',
                type = 'success',
                duration = 8000,
                position = 'top'
            })
        else 
            lib.notify({
                title = 'Tow',
                description = 'Canceled removing the contract.',
                type = 'error',
                duration = 8000,
                position = 'top'
            })
        end
end)

RegisterNetEvent('koe_towing:selectedTow')
AddEventHandler('koe_towing:selectedTow', function(data)
    x = data.x
    y = data.y
    z = data.z
    local plate = data.selectedPlate
    local payout = data.payout
    
    blip = AddBlipForCoord(x, y , z)
    SetBlipSprite (blip, 225)
    SetBlipDisplay(blip, 2)
    SetBlipScale  (blip, 1.3)
    SetBlipColour (blip, 2)
    SetBlipAsShortRange(blip, true)

    BeginTextCommandSetBlipName('STRING')
    AddTextComponentSubstringPlayerName('Marked Tow Car')
    EndTextCommandSetBlipName(blip)

    SetBlipRoute(blip,true)

    if onJob == false then
        TriggerEvent('koe_towing:beginContract', plate, payout)
    else
        lib.notify({
            title = 'Tow',
            description = 'Already on a job',
            type = 'error',
            duration = 8000,
            position = 'top'
        })
    end
end)

RegisterNetEvent('koe_towing:beginContract')
AddEventHandler('koe_towing:beginContract', function(plate, payout)
    lib.notify({
        title = 'Tow',
        description = 'The vehicles location has been marked on your map, tow it back here for payment. The plate is '..plate,
        type = 'inform',
        duration = 10000,
        position = 'top'
    })

    sphere = lib.zones.sphere({
        coords = Config.DropOffLocation,
        radius = 10,
        debug = false,
        inside = inside,
        onEnter = onEnter,
        plate = plate,
        payout = payout,
        onExit = onExit
    })
    
    blip2 = AddBlipForCoord(Config.DropOffLocation)
    SetBlipSprite (blip2, 161)
    SetBlipDisplay(blip2, 2)
    SetBlipScale  (blip2, 1.3)
    SetBlipColour (blip2, 1)
    SetBlipAsShortRange(blip2, true)

    BeginTextCommandSetBlipName('STRING')
    AddTextComponentSubstringPlayerName('DROP OFF')
    EndTextCommandSetBlipName(blip2)
end)
function onEnter(self)
    lib.notify({
        title = 'Tow',
        description = 'Get into the vehicle then press E, unless you are already in it.',
        type = 'inform',
        duration = 10000,
        position = 'top'
    })
end

function inside(self)
    inZone = true
    plate = sphere.plate
    payout = sphere.payout

    if IsPedOnFoot(PlayerPedId()) == false then
        lib.showTextUI('[E] - To turn in vehicle')

        if IsControlJustReleased(0, 38) then
            local currentCar = lib.getVehicleProperties(GetVehiclePedIsUsing(PlayerPedId()))
            local currentPlate = currentCar.plate

            if currentCar == nil then
                lib.notify({
                    title = 'Tow',
                    description = 'You are not in a car....',
                    type = 'inform',
                    duration = 10000,
                    position = 'top'
                })
            else 
                RemoveBlip(blip)
                RemoveBlip(blip2)
                TriggerServerEvent('koe_towing:plateCheck',plate , currentPlate, payout)
                sphere:remove()
            end
            
        end
    end
end

function onExit(self)
    
end

RegisterNetEvent('koe_towing:deleteVehicle')
AddEventHandler('koe_towing:deleteVehicle', function(plate, payout)

    local currentCar = GetVehiclePedIsUsing(PlayerPedId())

    ESX.Game.DeleteVehicle(currentCar)

end)





