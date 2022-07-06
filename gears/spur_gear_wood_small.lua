
local S = gear3d.translator

local _shaft_sides = {"front", "back"}
local _shaft_types = {front="gear3d_small_wood",back="gear3d_small_wood"}
local _shaft_opposites = {back=true}

gear3d.register_machine("gear3d:spur_gear_wood_small",
  {
    -- machine def
	  node_description = S("Wood Small Spur Gear"),
    node_help = S("Can be greased.").."\n"..S("Shaft type adapter."),
    
    input_stack_size = 0,
    have_input = false,
    use_stack_size = 0,
    have_usage = false,
    output_stack_size = 0,
    
    _shaft_sides = _shaft_sides,
    _shaft_types = _shaft_types,
    _shaft_opposites = _shaft_opposites,
    _friction = 0.0025,
    _I = 225,
    
    _rpm_deactivate = true,
    _qgrease_max = 2,
    _qgrease_eff = 1,
    
    get_formspec = function() return "" end
  },{
    -- node def
    drawtype = "mesh",
    mesh = "gear3d_spur_gear.obj",
    use_texture_alpha = "clip",
    paramtype = "light",
    paramtype2 = "facedir",
    selectionbox = {-0.5, -0.5, -0.25, 0.5, 0.5, 0.25},
    groups = {cracky = 2, shaft = 1, greasable = 1},
    _shaft_sides = _shaft_sides,
    _shaft_types = _shaft_types,
    _shaft_opposites = _shaft_opposites,
  },{
    -- inactive node def
    tiles = {
      "gear3d_spur_gear_fwd.png^[verticalframe:24:0",
    },
  },{
    -- active node def
    tiles = {
      {
        image = "gear3d_spur_gear_fwd.png",
        animation = {
          type = "vertical_frames",
          aspect_w = 240,
          aspect_h = 16,
          length = 2.
        },
      },
    },
  },{
    -- reverse node def
    tiles = {
      {
        image = "gear3d_spur_gear_rev.png",
        animation = {
          type = "vertical_frames",
          aspect_w = 240,
          aspect_h = 16,
          length = 2.
        },
      },
    },
  },{
    -- broken node def
    description = S("Broken Wood Small Spur Gear"),
    drawtype = "mesh",
    mesh = "gear3d_spur_gear.obj",
    selectionbox = {-0.5, -0.5, -0.25, 0.5, 0.5, 0.25},
    tiles = "gear3d_spur_gear_fwd.png^[verticalframe:24:1",
  })

