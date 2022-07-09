
local S = gear3d.translator

gear3d.register_shaft("gear3d:chain_steel", {
    description = S("Steel Chain"),
	  drawtype = "mesh",
	  mesh = "gear3d_chain.obj",
    tiles = {
	    "gear3d_chain_fwd.png^[verticalframe:12:0",
    },
    paramtype = "light",
    paramtype2 = "facedir",
    
    groups = {cracky = 2, shaft = 2},
    
    _shaft_sides = {"front","back"},
    _shaft_types = {front="gear3d_chain", back="gear3d_chain"},
    _shaft_opposites = {back=true},
    
  },{
    on_construct = function(pos)
      local meta = minetest.get_meta(pos)
      meta:set_float("I", 3)
      meta:set_float("fric", 0.02)
    end,
  },{
    tiles = {
      {
	      image = "gear3d_chain_fwd.png",
        animation = {
          type = "vertical_frames",
          aspect_w = 48,
          aspect_h = 8,
          length = 1.
        },
      },
    },
    groups = {cracky = 2, shaft = 2, not_in_creative_inventory = 1},
  },{
    tiles = {
      {
	      image = "gear3d_chain_rev.png",
        animation = {
          type = "vertical_frames",
          aspect_w = 48,
          aspect_h = 8,
          length = 1.
        },
      },
    },
    groups = {cracky = 2, shaft = 2, not_in_creative_inventory = 1},
  })

