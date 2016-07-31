--[[
 	ShoulderBadgesExtra
	ZycaR (c) 2016
]]

if Server then
    Script.Load("lua/sbe_ShoulderBadgesConfig.lua")
    Script.Load("lua/Server.lua")
elseif Client then
    Script.Load("lua/Client.lua")
elseif Predict then
    Script.Load("lua/Predict.lua")
end