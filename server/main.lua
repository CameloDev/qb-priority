local QBCore = exports['qb-core']:GetCoreObject()

timermax = Config.time

cooldown = 0
pirtprog = false
ishold = false


QBCore.Commands.Add("pirton", "To active the priority", {}, false, function(source, args)
	local Player = QBCore.Functions.GetPlayer(source)
	if Player.PlayerData.job.name == Config.job then
	TriggerEvent("qb-priority:server:pirton")
	TriggerEvent('qb-log:server:CreateLog', 'priority', 'priority Status : ON', 'green', '** Officer ID card number : ' ..Player.PlayerData.citizenid.. " \n Officer Name : " ..Player.PlayerData.charinfo.firstname.. " " ..Player.PlayerData.charinfo.lastname.. "**")
	    else
        TriggerClientEvent('chatMessage', source, "Police SYSTEM", "error", "You can't use this command !")
		end
end)

QBCore.Commands.Add("pirtoff", "Turn off the priority", {}, false, function(source, args)
	local Player = QBCore.Functions.GetPlayer(source)
	if Player.PlayerData.job.name == Config.job then
	TriggerEvent("qb-priority:server:pirtoff")
	TriggerEvent('qb-log:server:CreateLog', 'priority', 'priority Status : OFF', 'red', '** Officer ID card number : ' ..Player.PlayerData.citizenid.. " \n Officer Name : " ..Player.PlayerData.charinfo.firstname.. " " ..Player.PlayerData.charinfo.lastname.. "**")
	    else
        TriggerClientEvent('chatMessage', source, "Police SYSTEM", "error", "You can't use this command !")
		end
end)

QBCore.Commands.Add("pirtprog", "Announce that there is a priority coming", {}, false, function(source, args)
	local Player = QBCore.Functions.GetPlayer(source)
	if Player.PlayerData.job.name == Config.job then
	TriggerEvent('qb-priority:server:pirtprog')
	TriggerEvent('qb-log:server:CreateLog', 'priority', 'priority Status : progress', 'orange', '** Officer ID card number : ' ..Player.PlayerData.citizenid.. " \n Officer Name : " ..Player.PlayerData.charinfo.firstname.. " " ..Player.PlayerData.charinfo.lastname.. "**")
	    else
        TriggerClientEvent('chatMessage', source, "Police SYSTEM", "error", "You can't use this command !")
		end
end)

QBCore.Commands.Add("pirthold", "Put the priority on hold", {}, false, function(source, args)
	local Player = QBCore.Functions.GetPlayer(source)
	if Player.PlayerData.job.name == Config.job then
	TriggerEvent('qb-priority:server:pirthold')
	TriggerEvent('qb-log:server:CreateLog', 'priority', 'priority Status : Hold', 'yellow', '** Officer ID card number : ' ..Player.PlayerData.citizenid.. " \n Officer Name : " ..Player.PlayerData.charinfo.firstname.. " " ..Player.PlayerData.charinfo.lastname.. "**")
	    else
        TriggerClientEvent('chatMessage', source, "Police SYSTEM", "error", "You can't use this command !")
    end
end)

RegisterNetEvent('qb-priority:server:pirtprog')
AddEventHandler('qb-priority:server:pirtprog', function()
	pirtprog = true
	Citizen.Wait(1)
	TriggerClientEvent('chatMessage', -1, "Police SYSTEM", "error", "Theris priority coming")
	TriggerClientEvent('qb-priority:server:UpdatePriority', -1, pirtprog)
end)

RegisterNetEvent('qb-priority:server:pirthold')
AddEventHandler('qb-priority:server:pirthold', function()
	ishold = true
	Citizen.Wait(1)
	TriggerClientEvent('chatMessage',-1, "Police SYSTEM", "error", "All criminal things are now disabled")
	TriggerClientEvent('qb-priority:server:UpdateHold', -1, ishold)
end)

RegisterNetEvent("qb-priority:server:pirton")
AddEventHandler("qb-priority:server:pirton", function()
	if pirtprog == true then
		pirtprog = false
		TriggerClientEvent('qb-priority:server:UpdatePriority', -1, pirtprog)
	end
	Citizen.Wait(1)
	if ishold == true then
		ishold = false
		TriggerClientEvent('qb-priority:server:UpdateHold', -1, ishold)
	end
	Citizen.Wait(1)
	if cooldown == 0 then
		cooldown = 0
		cooldown = cooldown + timermax
		while cooldown > 0 do
			cooldown = cooldown - 1
			TriggerClientEvent('qb-priority:server:UpdateCooldown', -1, cooldown)
	TriggerClientEvent('chatMessage',-1, "Police SYSTEM","error", "All criminal things are now disabled")					
			Citizen.Wait(60000)
		end
	elseif cooldown ~= 0 then
		CancelEvent()
	end
end)

RegisterNetEvent("qb-priority:server:pirtoff")
AddEventHandler("qb-priority:server:pirtoff", function()
	Citizen.Wait(1)
	TriggerClientEvent('chatMessage', -1, "Police SYSTEM", "error", "Priority are off now")
	while cooldown > 0 do
		cooldown = cooldown - 1
		TriggerClientEvent('qb-priority:server:UpdateCooldown', -1, cooldown)
		Citizen.Wait(100)
	end
	
end)