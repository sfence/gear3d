
local modpath = minetest.get_modpath(minetest.get_current_modname()).."/gears"

dofile(modpath.."/shaft.lua")
dofile(modpath.."/machine.lua")
dofile(modpath.."/chain.lua")

dofile(modpath.."/shaft_wood_small.lua")
dofile(modpath.."/chain_steel.lua")

dofile(modpath.."/shaft_adapter_wood_small.lua")

dofile(modpath.."/spur_gear_wood_small.lua")
dofile(modpath.."/cage_gear_female_wood_small.lua")
dofile(modpath.."/cage_gear_female_wood_large.lua")
dofile(modpath.."/cage_gear_male_wood_single.lua")
dofile(modpath.."/cage_gear_male_wood_double.lua")
dofile(modpath.."/sprocket_wheel_no_chain.lua")
dofile(modpath.."/sprocket_wheel_chain_90.lua")
dofile(modpath.."/sprocket_wheel_chain_180.lua")

--dofile(modpath.."/windsail.lua")

