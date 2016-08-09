--[[
 	ShoulderPatchesExtra
	ZycaR (c) 2016
	
NOTE: Shared message from clients to server.
Should be included in any file working with message
]]

if not kSetShoulderPatchMessage then

    kSetShoulderPatchMessage = {
        spePatchIndex = "integer (0 to 1024)",
    }
    Shared.RegisterNetworkMessage("SetShoulderPatch", kSetShoulderPatchMessage)
    
    if Client then
        function SendShoulderPatchUpdate(index)
            if MainMenu_IsInGame and MainMenu_IsInGame() then
                Client.SendNetworkMessage("SetShoulderPatch", { 
                    spePatchIndex = index
                }, true)
            end
        end
    end

    if Server then
        local function OnSetShoulderPatch(client, message)
            local player = client and client:GetControllingPlayer()
            if player and HasMixin(player, "ShoulderPatches") then
                player:SetShoulderPatchIndex(message.spePatchIndex or 0)
            end
        end
        Server.HookNetworkMessage("SetShoulderPatch", OnSetShoulderPatch)
    end

end