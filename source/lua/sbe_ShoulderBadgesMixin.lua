--[[
 	ShoulderBadgesExtra
	ZycaR (c) 2016
]]

ShoulderBadgesMixin = CreateMixin( ShoulderBadgesMixin )
ShoulderBadgesMixin.type = "ShoulderBadges"

ShoulderBadgesMixin.kShaderName = "models/marine/patches/ShoulderBadgesMixin.surface_shader"
ShoulderBadgesMixin.kBadgesList = {
    "models/marine/patches/sbe_opac.dds",
    "models/marine/patches/sbe_emissive.dds"
}

ShoulderBadgesMixin.networkVars =
{
    sbeBadgeIndex = "integer (0 to 255)"
}

ShoulderBadgesMixin.expectedMixins =
{
	Model = "Needed for setting material parameters"
}

ShoulderBadgesMixin.expectedCallbacks = {}
ShoulderBadgesMixin.optionalCallbacks = {}

function ShoulderBadgesMixin:__initmixin()
    self.sbeBadgeIndex = 0
end

if Server then

    local function OnClientConnect(client)
        if client and not client:GetIsVirtual() then
            local player = client:GetControllingPlayer()
            local index = GetShoulderBadgeIndex(client)
            if player and index then
                player.sbeBadgeIndex = index
            end
        end
    end
    Event.Hook("ClientConnect", OnClientConnect)

end

if Client then

    -- precache shader and textures
    Shared.PrecacheSurfaceShader(ShoulderBadgesMixin.kShaderName)
    for _, badges in ipairs(ShoulderBadgesMixin.kBadgesList) do
        PrecacheAsset(badges)
    end

    function ShoulderBadgesMixin:OnUpdateRender()
        local model = self:GetRenderModel()
        if model ~= nil then
            model:SetMaterialParameter( "sbeBadgeIndex", self.sbeBadgeIndex)
        end
    end
    
end -- Client

