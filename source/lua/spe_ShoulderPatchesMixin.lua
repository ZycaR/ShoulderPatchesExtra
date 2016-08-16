--[[
 	ShoulderPatchesExtra
	ZycaR (c) 2016
]]
Script.Load("lua/spe_ShoulderPatchesConfig.lua")
Script.Load("lua/spe_ShoulderPatchesMessage.lua")

ShoulderPatchesMixin = CreateMixin( ShoulderPatchesMixin )
ShoulderPatchesMixin.type = "ShoulderPatches"

ShoulderPatchesMixin.kShaderName = "models/marine/patches/ShoulderPatchesExtra.surface_shader"
ShoulderPatchesMixin.kPatchMaps = {
    "models/marine/patches/ShoulderPatchesExtra.dds"
}

ShoulderPatchesMixin.networkVars =
{
    spePatchIndex = "integer (0 to 1024)",
    spePatchEffect = "integer (0 to 1)",
    spePatches = "string (256)"
}

ShoulderPatchesMixin.expectedMixins =
{
	Model = "Needed for setting material parameters"
}

ShoulderPatchesMixin.expectedCallbacks = {}
ShoulderPatchesMixin.optionalCallbacks = {}

function ShoulderPatchesMixin:__initmixin()
    self.spePatchIndex = 0
    self.spePatchEffect = 0
    self.spePatches = nil
    self.speOptionsSent = false
end

if Server then

    local function OnClientConnect(client)
        if client and not client:GetIsVirtual() then
            local player = client:GetControllingPlayer()
            local patches = ShoulderPatchesConfig:GetShoulderPatches(client)
            if player and patches then
                player.spePatchIndex = 0
                player.spePatchEffect = 0
                player.spePatches = patches
            end
        end
    end
    Event.Hook("ClientConnect", OnClientConnect)

    function ShoulderPatchesMixin:SetShoulderPatchIndex(value)
        self.spePatchIndex = value
    end
    
    function ShoulderPatchesMixin:SetShoulderPatchEffect(value)
        self.spePatchEffect = value
    end

end

if Client then

    -- precache shader and textures
    Shared.PrecacheSurfaceShader(ShoulderPatchesMixin.kShaderName)
    for _, texture in ipairs(ShoulderPatchesMixin.kPatchMaps) do
        PrecacheAsset(texture)
    end
    
    function ShoulderPatchesMixin:GetValidShoulderPatchIndex()
        if not self.speOptionsSent and self.spePatches and self.spePatches ~= "" then
            self.speOptionsSent = true
            local name, index = ShoulderPatchesConfig:GetClientShoulderPatch(self)
            self.spePatchIndex = index
            SendShoulderPatchUpdate(self.spePatchIndex)
        end
        return self.spePatchIndex
    end
    
    function ShoulderPatchesMixin:OnUpdateRender()
        local model = self:GetRenderModel()
        if model ~= nil then
            model:SetMaterialParameter("spePatchIndex", self:GetValidShoulderPatchIndex())
            model:SetMaterialParameter("spePatchEffect", self.spePatchEffect or 0)
        end
    end
    
end -- Client

