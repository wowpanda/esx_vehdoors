ESX                             = nil

local hot_key = 208 --HOTKEY ID * 208 = PGUP *

local Window1 = 1
local Window2 = 1
local Window3 = 1
local Window4 = 1
local Windows1 = 1
local Windows2 = 1
local WindowsAll = 1
local Engine = true


--Initialize ESX Framework
Citizen.CreateThread(function()
  while ESX == nil do
    TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
    Citizen.Wait(0)
  end
end)

function CloseDoor(doors) --doors = doors game id

	local playerPed = GetPlayerPed(-1) --Getting Player Ped
	if ( IsPedSittingInAnyVehicle( playerPed ) ) then --Checking If Player Is Sitting In Any Vehicle
		local playerVeh = GetVehiclePedIsIn(playerPed, false --Getting Player Vehicle
       if GetVehicleDoorAngleRatio(playerVeh, doors) > 0.0 then --Checking Angle Ratio Of Hood 
          SetVehicleDoorShut(playerVeh, doors, false) --Shutting The Doors             
        else
          SetVehicleDoorOpen(playerVeh, doors, false) --Opening The Doors             
       end
    end
	
end

function WindowRightFront()
    local playerPed = GetPlayerPed(-1)
    local playerVeh = GetVehiclePedIsIn(playerPed, false)
    if ( IsPedSittingInAnyVehicle( playerPed ) ) and Window1 == 0 then
      RollUpWindow(playerVeh, 1)
      Window1 = 1
    else
        RollDownWindow(playerVeh, 1)
        Window1 = 0
    end
    return Window1
end

function WindowLeftFront()
    local playerPed = GetPlayerPed(-1)
    local playerVeh = GetVehiclePedIsIn(playerPed, false)
    if ( IsPedSittingInAnyVehicle( playerPed ) ) and Window2 == 0 then
      RollUpWindow(playerVeh, 0)
      Window2 = 1
    else
        RollDownWindow(playerVeh, 0)
        Window2 = 0
    end

end

function WindowLeftRear()
    local playerPed = GetPlayerPed(-1)
    local playerVeh = GetVehiclePedIsIn(playerPed, false)
    if ( IsPedSittingInAnyVehicle( playerPed ) ) and Window3 == 0 then
      RollUpWindow(playerVeh, 2)
      Window3 = 1
    else
        RollDownWindow(playerVeh, 2)
        Window3 = 0
    end
end

function WindowRightRear()
    local playerPed = GetPlayerPed(-1)
    local playerVeh = GetVehiclePedIsIn(playerPed, false)
    if ( IsPedSittingInAnyVehicle( playerPed ) ) and Window4 == 0 then
      RollUpWindow(playerVeh, 3)
      Window4 = 1
    else
        RollDownWindow(playerVeh, 3)
        Window4 = 0
    end
end

function WindowsFront()
    local playerPed = GetPlayerPed(-1)
    local playerVeh = GetVehiclePedIsIn(playerPed, false)
    if ( IsPedSittingInAnyVehicle( playerPed ) ) and Windows1 == 0 then
      RollUpWindow(playerVeh, 1)
      RollUpWindow(playerVeh, 0)
      Windows1 = 1
    else
        RollDownWindow(playerVeh, 1)
        RollDownWindow(playerVeh, 0)
        Windows1 = 0
    end
end

function WindowsRear()
    local playerPed = GetPlayerPed(-1)
    local playerVeh = GetVehiclePedIsIn(playerPed, false)
    if ( IsPedSittingInAnyVehicle( playerPed ) ) and Windows2 == 0 then
      RollUpWindow(playerVeh, 2)
      RollUpWindow(playerVeh, 3)
      Windows2 = 1
    else
        RollDownWindow(playerVeh, 2)
        RollDownWindow(playerVeh, 3)
        Windows2 = 0
    end
end

function WindowsAll()
    local playerPed = GetPlayerPed(-1)
    local playerVeh = GetVehiclePedIsIn(playerPed, false)
    if ( IsPedSittingInAnyVehicle( playerPed ) ) and WindowsAll == 0 then
      RollUpWindow(playerVeh, 0)
      RollUpWindow(playerVeh, 1)
      RollUpWindow(playerVeh, 2)
      RollUpWindow(playerVeh, 3)
      WindowsAll = 1
    else
        RollDownWindow(playerVeh, 0)
        RollDownWindow(playerVeh, 1)
        RollDownWindow(playerVeh, 2)
        RollDownWindow(playerVeh, 3)
        WindowsAll = 0
    end
end

function EningeFunc()
    local playerPed = GetPlayerPed(-1)
    local playerVeh = GetVehiclePedIsIn(playerPed, false)
    local isEngineOn = GetIsVehicleEngineRunning(playerVeh)
    if isEngineOn then
        SetVehicleEngineOn(playerVeh, false, false, true)
    elseif not isEngineOn then
        SetVehicleEngineOn(playerVeh, true, false, true)
    end
end


function DoorsMenu()
	ESX.UI.Menu.Open(
	  'default', GetCurrentResourceName(), 'vehicle_menu',
	  {
      title    = 'Menu Drzwi',
      align = "top-left",
		  elements = {
			  {label = 'Front Right Doors', value = 'f_r_doors'},
			  {label = 'Front Left Doors', value = 'f_l_doors'},
			  {label = 'Rear Right Doors', value = 'r_r_doors'},
			  {label = 'Rear Left Doors', value = 'r_l_doors'},
			  {label = 'Hood', value = 'hood'},
              {label = 'Trunk', value = 'trunk'},
		  }
	  },
	  function(data, menu)
		  local val = data.current.value
		  
		  if val == 'f_r_doors' then
			  CloseDoor(1)
		  elseif val == 'f_l_doors' then
			  CloseDoor(0)
		  elseif val == 'r_r_doors' then
			  CloseDoor(3)
          elseif val == 'r_l_doors' then
              CloseDoor(2)
          elseif val == 'hood' then
              CloseDoor(4)
          elseif val =='trunk' then
              CloseDoor(5)
		  end
	  end,
	  function(data, menu)
		  menu.close()
	  end
  )
end

function WindowsMenu()
	ESX.UI.Menu.Open(
	  'default', GetCurrentResourceName(), 'vehicle_menu',
	  {
      title    = 'Windows',
      align = "top-left",
		  elements = {
			  {label = 'Front Right Window', value = 'f_r_window'},
			  {label = 'Front Left Window', value = 'f_l_window'},
			  {label = 'Rear Right Window', value = 'r_r_window'},
			  {label = 'Rear Left Window', value = 'r_l_window'},
			  {label = 'Front Windows', value = 'f_windows'},
              {label = 'Rear Windows', value = 'r_windows'},
              {label = 'All Windows', value = 'a_windows'},
		  }
	  },
	  function(data, menu)
		  local val = data.current.value
		  
		  if val == 'f_r_window' then
			  WindowRightFront()
		  elseif val == 'f_l_window' then
			  WindowLeftFront()
		  elseif val == 'r_r_window' then
			  WindowRightRear()
          elseif val == 'r_l_window' then
              WindowLeftRear()
          elseif val == 'f_windows' then
               WindowsFront()
          elseif val == 'r_windows' then
               WindowsRear()
          elseif val == 'a_windows' then
               WindowsAll()
		  end
	  end,
	  function(data, menu)
		  menu.close()
	  end
  )
end

function openMenu()
	ESX.UI.Menu.Open(
	  'default', GetCurrentResourceName(), 'vehicle_menu1',
	  {
      title    = 'Vehicle Menu',
      align = "top-left",
		  elements = {
              {label = 'Doors', value = 'doors'},
              {label = 'Windows', value = 'windows'},
			  {label = 'Toggle Engine', value = 'engine'},
		  }
	  },
	  function(data, menu)
		  local val = data.current.value
		  
		  if val == 'doors' then
				DoorsMenu()
		  elseif val == 'windows' then
				WindowsMenu()
		  elseif val == 'engine' then
				EngineFunc()
		  end
	  end,
	  function(data, menu)
		  menu.close()
	  end
  )
end

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(0)
        local ped = GetPlayerPed(-1)
        if IsPedSittingInAnyVehicle(ped) then
            if IsControlJustPressed(1, hot_key) then
                openMenu()
            end
        end
    end
end)