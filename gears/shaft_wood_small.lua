
local S = gear3d.translator

gear3d.register_shaft("gear3d:shaft_wood_small", {
  },{
  },{
    description = S("Wood Small Shaft"),
	  drawtype = "mesh",
	  mesh = "gear3d_shaft_small.obj",
    tiles = {
	    "gear3d_shaft_small.png^[verticalframe:12:0",
    },
    paramtype2 = "facedir",
    
    groups = {cracky = 2, shaft = 2},
    
    _shaft_sides = {"front","back"},
    _shaft_types = {front="gear3d_small_wood", back="gear3d_small_wood"},
    
    on_construct = function(pos)
      local meta = minetest.get_meta(pos)
      meta:set_float("I", 3)
      meta:set_float("fric", 0.02)
    end,
  },{
  })

