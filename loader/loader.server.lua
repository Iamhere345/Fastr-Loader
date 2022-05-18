local InsertService = game:GetService("InsertService")

local channels = { --other channels coming soon
	["STABLE"] = 7981493975, -- Fastr stable MainModule. can be found here: https://www.roblox.com/library/7981493975/
	["UNSTABLE"] = 8255856192, -- Fastr unstable MainModule. can be found here: https://www.roblox.com/library/8255856192/
	["EXPERIMENTAL"] = 8255993359, -- Fastr experimental MainModule. can be found here: https://www.roblox.com/library/8255993359/
	["COMPATABILITY"] = 0000
}

--!!! YOU MUST HAVE THE MAINMODULE YOU WANT TO USE IN YOUR INVENTORY TO USE IT

local UPDATE_CHANNEL = channels["STABLE"]  --options for the update channel: this is the main version "STABLE" this is the version i use for features that currently don't work well "UNSTABLE" this is what i use for prototyping ideas for fastr "EXPERIMENTAL" if you get a warning saying that your loader version is too old then switch your update channel to "COMPATABILITY"
local LoaderVersion = "0.1.0" --if you change this it could stop fastr to stop working for you. this is used to check the compatability of your version of the loader and the latest version of
local ModuleVersion = InsertService:GetLatestAssetVersionAsync(UPDATE_CHANNEL) -- change this to a different version of Fastr if you want. If you keep it the same you will receive automatic updates 

local Fastr = InsertService:LoadAsset(UPDATE_CHANNEL)
Fastr.Parent = workspace

local module = require(Fastr)
module:init(script.Parent, LoaderVersion)

script.Parent:Destroy()
--0.66