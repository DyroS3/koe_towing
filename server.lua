----Gets ESX-----
ESX = nil
local ox_inventory = exports.ox_inventory
TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
----------------------------------------------------------------

RegisterNetEvent('koe_towing:checkOwned')
AddEventHandler('koe_towing:checkOwned', function(targetPlate, owned, targetModel, primaryColor, playerCoords)
        local src = source
        local owned = false

        local result = exports.oxmysql:scalar_async('SELECT plate FROM owned_vehicles WHERE plate = @plate', {
            ['@plate'] = targetPlate
        })

        if result then owned = true end

        TriggerClientEvent('koe_towing:menu', src, targetPlate, owned, targetModel, primaryColor, playerCoords)
end)

RegisterNetEvent('koe_towing:marked')
AddEventHandler('koe_towing:marked', function(location, plate, owned, model, color)
    
    MySQL.Async.execute('INSERT INTO koe_towing (plate, owned, model, color, coords) VALUES (@plate, @owned, @model, @color, @coords)', {
        ['@plate'] = tostring(plate),
        ['@owned'] = tostring(owned),
        ['@model'] = tostring(model),
        ['@color'] = tostring(color),
        ['@coords']  = tostring(location),
    })
end)

RegisterNetEvent('koe_towing:getTows')
AddEventHandler('koe_towing:getTows', function()
    local src = source

    MySQL.Async.fetchAll('SELECT * FROM koe_towing ',
    { }, 
    function(result)
        TriggerClientEvent('koe_towing:towsMenu', src, result)
    end)
   
end)



