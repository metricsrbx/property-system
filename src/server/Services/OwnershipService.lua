--[[
	A service designed to manage the Ownership of cached Properties.
	This is a simplistic approach and is actively being reviewed.

	Author: M_etrics
	Date: 21/02/2024
	Version: 1.0.0
]]

--TODO: Ownership transfer method

local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Packages = ReplicatedStorage.PropertyShared.Packages

local TableUtil = require(Packages.TableUtil)

local PropertyTemplate = {
	Owner = nil,
	Accessors = {},
}
export type Property = {
	Owner: Player,
	Accessors: { [number]: (Accessor: Player) -> nil },
}

local Service = {}
local PropertyCache = {}


function Service:GetPlayerPlot(Player: Player): Property | nil
	local query = TableUtil.Find(PropertyCache, function(Property)
		return Property.Name == Player.Name
	end)

	return query
end

function Service:IssueOwnership(
	Plot: Instance | nil,
	Owner: Player | nil,
	Accessors: { [number]: (Accessor: Player) -> nil }
): boolean
	if not PropertyCache[Plot] then
		local correctedData = TableUtil.Reconcile({
			Owner = Owner,
			Accessors = Accessors,
		}, PropertyTemplate)

		if correctedData.Owner == nil then
			return false
		end

		PropertyCache[Plot] = correctedData
		return true
	else
		warn("Plot already exists in Cache!")
		return false
	end
end

function Service:RemovePlayerOwnership(Plot: Instance | nil, Owner: Player | nil, allowReplacement: boolean?): boolean
	local property: Property | nil = PropertyCache[Plot]

	if property == nil then
		return false
	end

	if property.Owner == Owner then
		if allowReplacement then
			if #property.Accessors > 1 then
				property.Owner = property.Accessors[1]
				TableUtil.SwapRemove(property.Accessors, 1)
				return true
			else
				PropertyCache[Plot] = nil
				return true
			end
		else
			PropertyCache[Plot] = nil
			return true
		end
	end

	return false
end

function Service:AddAccessor(plot: Instance | nil, player: Player): boolean
	local property: Property | nil = PropertyCache[plot]

	if property == nil then
		return false
	end

	for _, accessor in ipairs(property.Accessors) do
		if accessor == player then
			return true -- Already exists
		end
	end

	table.insert(property.Accessors, player)
	return true
end

function Service:RemoveAccessor(plot: Instance | nil, player: Player): boolean
	local property: Property | nil = PropertyCache[plot]

	if property == nil then
		return false
	end

	for i, accessor in ipairs(property.Accessors) do
		if accessor == player then
			TableUtil.SwapRemove(property.Accessors, i)
			return true
		end
	end

	return true
end

function Service:HasAccess(plot: Instance | nil, player: Player): boolean
	local property = PropertyCache[plot]

	if property == nil then
		return false -- Property fails to exist
	end

	if player == property.Owner then
		return true --Player is the owner
	end

	for _, accessor in ipairs(property.Accessors) do
		if accessor == player then
			return true --Player is an accessor
		end
	end

	return false --Player does not have access
end

function Service:Start()
	Players.PlayerRemoving:Connect(function(player)
		local plot = self:GetPlayerPlot(player)
		if plot then
			self:RemovePlayerOwnership(plot, player, true)
			print(PropertyCache, true)
		end
	end)
end

return Service
