local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Packages = ReplicatedStorage.PropertyShared.Packages

local Loader = require(Packages.Loader)

Loader.SpawnAll(
	Loader.LoadDescendants(script.Controllers, Loader.MatchesName("Controller$")),
	"Start"
)

Loader.LoadDescendants(script.Components)