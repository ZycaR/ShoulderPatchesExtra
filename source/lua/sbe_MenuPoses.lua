--[[
 	ShoulderBadgesExtra
	ZycaR (c) 2016
]]

local ns2_Update = MenuPoses.Update
function MenuPoses:Update(deltaTime)
    ns2_Update(self, deltaTime)
    
    -- set parameters to properly render menu poses badge
    local model = model.renderModel
    local player = Client.GetLocalPlayer()
    if MainMenu_GetIsOpened() and model ~= nil and player ~= nil then
        model:SetMaterialParameter("sbeBadgeIndex", player.sbeBadgeIndex)
    end
end
