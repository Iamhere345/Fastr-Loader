type svf2 = {major: number, minor: number, patch: number}

local function tosvf(version_str: string): svf2 --read and compare the loader version in semantic version format 2.0.0 (e.g version 1.0.0)
	
	local versionSplit = string.split(version_str, ".")

	local major = tostring(versionSplit[1])
	local minor = tostring(versionSplit[2])
	local fix = tostring(versionSplit[3])

	return {major, minor, fix}

end

local function cmpgt_svf(a: svf2, b: svf2)
    for i,n in pairs(a) do
        if n > b[i] then
            return true
        end
    end

    return false

end


local a: svf2 = tosvf("1.2.3")
local b: svf2 = tosvf("1.2.3")

if cmpgt_svf(a, b) then
    print("good")
end

