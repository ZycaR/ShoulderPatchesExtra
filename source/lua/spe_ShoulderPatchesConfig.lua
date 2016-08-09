--[[
 	ShoulderPatchesExtra
	ZycaR (c) 2016
]]

Script.Load("lua/ConfigFileUtility.lua")

kDefaultPatch = 0
kDefaultGroup = "None"

ShoulderPatchesConfig = {}
ShoulderPatchesConfig.ConfigFileName = "ShoulderPatchesConfig.json"
ShoulderPatchesConfig.PatchNames = {
    "SuperAdmin",
    "ZycaR",
    "Nalice"
}

if Server then

    local kDefaultConfig = {
        PatchGroups = {
            [kDefaultGroup] = { },
            SuperAdmin      = { "1", "2", "3" },
            zycar           = { "2", "3" },
            nalice          = { "3" }
        },
        Users = {
            ["90000000000001"] = kDefaultGroup,
            --["57727861"] = "SuperAdmin",
            --["40820346"] = "zycar",
            --["118678504"] = "nalice"
        }
    }

    ShoulderPatchesConfig._config = LoadConfigFile(
        ShoulderPatchesConfig.ConfigFileName,
        kDefaultConfig, true)

    local function GetShineGroup(steamId)
        if Shine and Shine.UserData then
            local data = Shine.UserData.Users[steamId]
            return data and data.Group
        end
    end

    function ShoulderPatchesConfig:GetShoulderPatches(client)
        local steamId = tostring(client:GetUserId())
        local group =  self._config.Users[steamId] or GetShineGroup(steamId) or kDefaultGroup
    	local patches = group and self._config.PatchGroups[ group ] or {}
    	local result = table.concat(patches, ",")
    	
    	Shared.Message(".. SteamID: ".. steamId .. ".. ShouderPatchesExtra: " .. result)
        return result
    end

end

if Client then
    local function GetShoulderPatchIndexByName(config, value)
        if value ~= kDefaultGroup then
            for index, name in pairs(config.PatchNames) do
                if name == value then return index end
            end
        end
        return kDefaultPatch
    end

    local function GetShoulderPatchIndexes(player)
        if player and HasMixin(player, "ShoulderPatches") then
            return StringSplit(player.spePatches or "", ",")
        end
        return { }
    end

    function ShoulderPatchesConfig:GetClientShoulderPatchNames(player)
        local result = { }
        table.insert(result, kDefaultGroup)
        for _, patch in ipairs(GetShoulderPatchIndexes(player)) do
            local patch = self.PatchNames[ tonumber(patch) ]
            if patch then table.insertunique(result, patch) end
        end
        return result
    end

    function ShoulderPatchesConfig:GetClientShoulderPatch(player)
        local index = Client.GetOptionInteger("spe", kDefaultPatch)
        
        if not self.PatchNames[ index ] then
            Client.SetOptionInteger("spe", kDefaultPatch)
            index = kDefaultPatch
        elseif not table.contains(GetShoulderPatchIndexes(player), tostring(index)) then
            index = kDefaultPatch
        end
        return self.PatchNames[ index ] or kDefaultGroup, index
    end

    function ShoulderPatchesConfig:SetClientShoulderPatch(name)
        local index = GetShoulderPatchIndexByName(self, name)
        Client.SetOptionInteger("spe", index)
        --Shared.Message("SetClientShoulderPatch: ".. tostring(index))
        return index
    end

end
