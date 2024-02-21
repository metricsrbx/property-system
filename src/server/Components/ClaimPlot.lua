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

local ClaimPlot = Component.new({
	Tag = "ClaimPlot",
	Ancestors = { workspace },
})

function ClaimPlot:Construct()
	self._Janitor = Janitor.new()
	self.Claimed = false
end

function ClaimPlot:Start()
	local robloxInstance: ProximityPrompt? = self.Instance
	self._Janitor:LinkToInstance(robloxInstance)
	self.PropertyModel = robloxInstance:FindFirstAncestorOfClass("Model")

	if robloxInstance:IsA("ProximityPrompt") then
		self._Janitor:Add(robloxInstance.Triggered:Connect(function(player: Player)
			if self.Claimed == false then
				local success = OwnershipService:IssueOwnership(self.PropertyModel, player, {})
				if success then
					robloxInstance.ActionText = "Abandon Property"
					self.Claimed = true
				else
					warn("Unsuccessful attempt to offer ownership of property!")
				end
			else
				local success = OwnershipService:RemovePlayerOwnership(self.PropertyModel, player)
				if success then
					robloxInstance.ActionText = "Claim Property"
					self.Claimed = false
				else
					warn("Unsuccessful attempt to abandon property!")
				end
			end
		end))
	end
end

function ClaimPlot:Stop()
	self._Janitor:Cleanup()
end

return ClaimPlot
