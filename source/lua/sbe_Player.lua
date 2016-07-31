--[[
 	ShoulderBadgesExtra
	ZycaR (c) 2016
]]

Script.Load("lua/sbe_ShoulderBadgesMixin.lua")

local ns2_OnInitialized = Player.OnInitialized
function Player:OnInitialized()
    InitMixin(self, ShoulderBadgesMixin)
    ns2_OnInitialized(self)
end

if Server then

    -- Copy sbeBadgeIndex from player to spectator and back for respawn purpose
    local ns2_CopyPlayerDataFrom = Player.CopyPlayerDataFrom
    function Player:CopyPlayerDataFrom(player)
        ns2_CopyPlayerDataFrom(self, player)
        self.sbeBadgeIndex = player.sbeBadgeIndex
    end

end

-- Modder's version of AddMixinNetworkVars()
Shared.LinkClassToMap("Player", Player.kMapName, ShoulderBadgesMixin.networkVars)