local M = {}

--[[
B = Base
H = House
R = Road
S = store
]]

local E = "empty"
local H = "house"
local B = "base"
local R = "road"
local S = "store"
local P = "policeStation"

function M.new()
	local map = {
		{H,R,H,H,R,H,H,R,H,H,R,H,H,R,H,H},
		{R,R,R,R,R,R,R,R,R,R,R,R,R,R,R,R},
		{S,R,H,H,R,H,R,R,R,H,R,H,H,R,H,H},
		{R,R,H,H,R,H,R,B,R,H,R,H,H,R,H,H},
		{R,R,R,R,R,R,R,R,R,R,R,R,R,R,R,R},
		{R,R,H,S,R,H,H,R,H,H,R,H,H,R,H,H},
		{R,R,H,H,R,H,H,R,H,H,R,H,S,R,H,H},
		{P,R,R,R,R,R,R,R,R,R,R,R,R,R,R,R},
	}

	return map
end


return M