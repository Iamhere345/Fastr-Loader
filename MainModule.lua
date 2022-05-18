local MainModule = {}

--! this code is old and may not conform to best practise.
-- todo cleanup this script
-- looking back on this the PascalCase is killing me

type svf2 = {major: number, minor: number, patch: number} --type for semantic version format 2.0.0

local MinimumLoaderVersion: svf2 = {major = 0, minor = 1, fix = 0} --todo fastr is only now following SemVer 2.0.0 format, but this isn't yet
local WarningLoaderVersion: svf2 = {major = 0, minor = 1, fix = 0}

local function tosvf(version_str: string): svf2 --read a string that represents an svf2 type (e.g "1.0.0") and convert it to svf2
	
	local versionSplit = string.split(version_str, ".")

	local major = tostring(versionSplit[1])
	local minor = tostring(versionSplit[2])
	local fix = tostring(versionSplit[3])

	return {major, minor, fix}

end

local function cmpgt_svf(a: svf2, b: svf2) --cmpgt_svf: compare greater than sematic version format. This compares two svf2 vars and returns true if a >= b, otherwise it returns false
    for i,n in pairs(a) do
        if n > b[i] then
            return true
        end
    end

	for i,n in pairs(a) do
		if n ~= b[i] then
			return false
		end
	end

    return true

end

local function CompileMenuWidgets(widgets,menu,MenuResources)

	for i,v in pairs(widgets:GetChildren()) do

		local newWidget = menu.Tabs.Help:Clone()
		newWidget.Parent = menu.Tabs
		newWidget.Name = v.Name
		newWidget.Text = v.Name

		v.Parent = MenuResources

	end

end

local function UpdateSettingsCompatability(Settings: table)
	
	local LatestSettings = {
		DefaultRank = 0,
		SoftLoad = false,
		Key = "FN6akfa93",
		Prefix = ":",
		PipeCharacter  = "|",
		RepeatCharacter = "*",
		AndCharacter = "+"
	}
	
	for k,s in pairs(LatestSettings) do
		if not Settings[k] then
			Settings[k] = s
		end
	end
	
end

function MainModule:init(root,loaderversion)

	loaderversion = tosvf(loaderversion)

	if cmpgt_svf(loaderversion,MinimumLoaderVersion) then

		if not cmpgt_svf(loaderversion, WarningLoaderVersion) then
			warn("your fastr loader is old and it is possible that it could become incompatable with fastr soon")
		end

		root.Settings.Parent = script.FastrPackage.Fastr_Main

		local Settings = require(script.FastrPackage.Fastr_Main.Settings)
		
		UpdateSettingsCompatability(Settings)
		
		if Settings.SoftLoad == true then

			local Cmds = script.FastrPackage.Fastr_Main.Core.Commands
			local Resources = script.FastrPackage.Fastr_Main.Resources
			local Remotes = script.FastrPackage.Fastr_Remotes

			for i,v in pairs(root.Commands:GetChildren()) do
				v.Parent = Cmds
				task.wait(0.05)
			end

			for i,v in pairs(root.Resources:GetChildren()) do
				v.Parent = Resources
				task.wait(0.05)
			end

			for i,v in pairs(root.Remotes:GetChildren()) do
				v.Parent = Remotes
				task.wait(0.05)
			end

		else

			for i,v in pairs(root.Commands:GetChildren()) do
				v.Parent = script.FastrPackage.Fastr_Main.Core.Commands
			end

			for i,v in pairs(root.Resources:GetChildren()) do
				v.Parent = script.FastrPackage.Fastr_Main.Resources
			end

			for i,v in pairs(root.Remotes:GetChildren()) do
				v.Parent = script.FastrPackage.Fastr_Remotes
			end

		end

		CompileMenuWidgets(root.MenuWidgets,script.FastrPackage.Fastr_UI.Resources.Menu,script.FastrPackage.Fastr_UI.Resources.MenuResources)
		
		if root:FindFirstChild("CoreCommandsEdits") then
			root.CoreCommandsEdits.Parent = script.FastrPackage.Fastr_Main.Utils.MiscUtils
		end
		
		task.wait(1)

		for i,player in pairs(game.Players:GetPlayers()) do
			local ui = script.FastrPackage.Fastr_UI:Clone()
			ui.Parent = player.PlayerGui
		end


		script.FastrPackage.FastInstall.Disabled = false

		script.FastrPackage:Clone().Parent = workspace

		script.FastrPackage:Destroy()

	else
		warn("your loader version in incompatable with the latest version of Fastr in this update channel. check the faq for more info and how to fix this")
		script.Parent:Destroy()
	end
end

return MainModule