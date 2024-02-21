--[[
	Thank you for using Property System, if you experience an issue or wish to contribute check out our github.
    https://github.com/metricsrbx/property-system

	Author: M_etrics
	Date: 21/02/2024
	Version: 1.0.0
]]

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Packages = ReplicatedStorage.PropertyShared.Packages

local Loader = require(Packages.Loader)

Loader.SpawnAll(
	Loader.LoadDescendants(script.Services, Loader.MatchesName("Service$")),
	"Start"
)

Loader.LoadDescendants(script.Components)