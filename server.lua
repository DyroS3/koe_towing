----Gets ESX-----
ESX = nil
local ox_inventory = exports.ox_inventory
TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
----------------------------------------------------------------

RegisterNetEvent('koe_towing:checkOwned')
AddEventHandler('koe_towing:checkOwned', function(targetPlate, owned, targetModel, primaryColor, playerCoords, targetVehicle)
        local src = source
        local owned = false

        local result = exports.oxmysql:scalar_async('SELECT plate FROM owned_vehicles WHERE plate = @plate', {
            ['@plate'] = targetPlate
        })

        if result then owned = true end

        TriggerClientEvent('koe_towing:menu', src, targetPlate, owned, targetModel, primaryColor, playerCoords)
end)

RegisterNetEvent('koe_towing:marked')
AddEventHandler('koe_towing:marked', function(location, plate, owned, model, color, x ,y ,z)
    local src = source
    local inDB = false
    local price = math.random(Config.minPayout,Config.maxPayout)
    local result = exports.oxmysql:scalar_async('SELECT plate FROM koe_towing WHERE plate = @plate', {
        ['@plate'] = plate
    })

    if result then inDB = true end

    if plate ~= nil then
        if inDB == false then 
            MySQL.Async.execute('INSERT INTO koe_towing (plate, owned, model, color, coords, price, x, y, z) VALUES (@plate, @owned, @model, @color, @coords, @price, @x, @y, @z)', {
                ['@plate'] = tostring(plate),
                ['@owned'] = tostring(owned),
                ['@model'] = tostring(model),
                ['@color'] = tostring(color),
                ['@coords']  = tostring(location),
                ['@price'] = price,
                ['@x'] = x,
                ['@y'] = y,
                ['@z'] = z,
            })

            TriggerClientEvent('ox_lib:notify', src, {type = 'success', description = 'Vehicle marked for towing.', duration = 8000, position = 'top'})
        else
            TriggerClientEvent('ox_lib:notify', src, {type = 'error', description = 'Vehicle already marked for towing.', duration = 8000, position = 'top'})
        end
    else
        TriggerClientEvent('ox_lib:notify', src, {type = 'error', description = 'Couldnt get the plate.', duration = 8000, position = 'top'})
    end
end)

RegisterNetEvent('koe_towing:plateCheck')
AddEventHandler('koe_towing:plateCheck', function(plate, currentPlate, payout)
    local src = source
    local xPlayer = ESX.GetPlayerFromId(src)
    local inDB2 = false
    local societyCut = 200

    local result = exports.oxmysql:scalar_async('SELECT plate FROM koe_towing WHERE plate = @plate', {
        ['@plate'] = plate
    })

    if result == currentPlate then 
        TriggerEvent('esx_addonaccount:getSharedAccount', 'society_towing', function(towing)
            if towing then
                towing.addMoney(societyCut)
            end
        end)
        TriggerEvent('esx_addonaccount:getSharedAccount', 'society_police', function(police)
            if police then
                police.addMoney(societyCut)
            end
        end)
        xPlayer.addInventoryItem('money', payout)
        TriggerClientEvent('koe_towing:deleteVehicle', src)
        exports.oxmysql:executeSync('DELETE FROM koe_towing WHERE plate = ? ', {plate})
        
        local identifier =  ESX.GetPlayerFromId(src).identifier
	    exports['koe_vendors']:giveCivLevel(identifier, 1)
        exports['koe_vendors']:giveCrimLevel(identifier, -10)
    else
        TriggerClientEvent('ox_lib:notify', src, {type = 'error', description = 'Wrong Vehicle', duration = 8000, position = 'top'})
    end
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

RegisterNetEvent('koe_towing:removeContract')
AddEventHandler('koe_towing:removeContract', function(plateToRemove)
    local src = source
    exports.oxmysql:executeSync('DELETE FROM koe_towing WHERE plate = ? ', {plateToRemove})
    TriggerClientEvent('ox_lib:notify', src, {type = 'success', description = 'Contract Removed', duration = 8000, position = 'top'})
end)



