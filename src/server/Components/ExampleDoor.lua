--[[
	A simple server-sided component to show the use of the Component system.
    You are free to add/remove/expand onto this, it is extremely simple.

	Author: M_etrics
	Date: 21/02/2024
	Version: 1.0.0
]]

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local ServerScriptService = game:GetService("ServerScriptService")

local Services = ServerScriptService.PropertySystem.Services
local Packages = ReplicatedStorage.PropertyShared.Packages

local OwnershipService = require(Services.OwnershipService)

local Component = require(Packages.Component)
local Janitor = require(Packages.Janitor)

local Door = Component.new({
	Tag = "ExampleDoor",
	Ancestors = { workspace },
})

function Door:Construct()
	self._Janitor = Janitor.new()
end

function Door:Start()
	local robloxInstance: ProximityPrompt? = self.Instance
	self._Janitor:LinkToInstance(robloxInstance)
	self.PropertyModel = robloxInstance:FindFirstAncestorOfClass("Model")
	self.DoorPart = robloxInstance:FindFirstAncestorOfClass("Part")
	if robloxInstance:IsA("ProximityPrompt") then
		self._Janitor:Add(robloxInstance.Triggered:Connect(function(player: Player)
			if OwnershipService:HasAccess(self.PropertyModel, player) then
				if self.DoorPart.CanCollide == true then
					self.DoorPart.CanCollide = false
				else
					self.DoorPart.CanCollide = true
				end
			else
				print("no access")
			end
		end))
	end
end

function Door:Stop()
	self._Janitor:Cleanup()
end

return Door
