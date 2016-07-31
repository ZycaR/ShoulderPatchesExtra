--[[
 	ShoulderBadgesExtra
	ZycaR (c) 2016
]]

Script.Load("lua/ConfigFileUtility.lua")
local kConfigFileName = "ShoulderBadgesConfig.json"

kDefaultGroup = "none"
local kDefaultConfig = {
    BadgeIndex = {
        [kDefaultGroup] = 0,
        SuperAdmin      = 1,
        zycar           = 2,
        nalice          = 3
    },
    Users = {
        ["90000000000001"] = kDefaultGroup,
        --["57727861"] = "SuperAdmin",
        --["40820346"] = "zycar",
        --["118678504"] = "nalice"
    }
}

if Server then

    local config = LoadConfigFile(kConfigFileName, kDefaultConfig, true)

    function GetShineGroup(steamId)
        if Shine and Shine.UserData then
            local data = Shine.UserData.Users[ tostring( steamId ) ]
            return data and data.Group
        end
    end

    function GetShoulderBadgeIndex(client)
        local steamId = client:GetUserId()
        local group = config.Users[ tostring( steamId ) ]

        if not group then
            group = GetShineGroup(steamId) or kDefaultBadgeGroup
        end
        Shared.Message(string.format("SteamID: %d - Group: %s",  steamId, group))

    	local index = config.BadgeIndex[ group ]
        if not index then
            Shared.Message(string.format("SteamID: %d - BadgeIndex: N/A", steamId))
            return nil
        end

        Shared.Message(string.format("SteamID: %d - BadgeIndex: %d", steamId, index))
        return index
    end

end