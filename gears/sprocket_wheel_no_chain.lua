
local S = gear3d.translator

local _shaft_sides = {"front", "back", "top","bottom","right","left"}
local _shaft_types = {front="gear3d_small_wood",back="gear3d_small_wood",top="gear3d_spu",bottom="gear3d_spu",right="gear3d_spu",left="gear3d_spu"}
local _shaft_opposites = {back=true,bottom=true,left=true}

gear3d.register_machine("gear3d:sprocket_wheel_wood_no_chain",
  {
    -- machine def
	  node_description = S("Wood Sprocket Wheel Without Chain"),
    node_help = S("Can be greased."),
    
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
    mesh = "gear3d_sprocket.obj",
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
      "gear3d_sprocket_fwd.png^[verticalframe:12:0",
    },
  },{
    -- active node def
    tiles = {
      {
        image = "gear3d_sprocket_fwd.png",
        animation = {
          type = "vertical_frames",
          aspect_w = 192,
          aspect_h = 30,
          length = 1.
        },
      },
    },
  },{
    -- reverse node def
    tiles = {
      {
        image = "gear3d_sprocket_rev.png",
        animation = {
          type = "vertical_frames",
          aspect_w = 192,
          aspect_h = 30,
          length = 1.
        },
      },
    },
  },{
    -- broken node def
    description = S("Broken Wood Sprocket Wheel"),
    drawtype = "mesh",
    mesh = "gear3d_sprocket.obj",
    selectionbox = {-0.5, -0.5, -0.25, 0.5, 0.5, 0.25},
    tiles = "gear3d_sprocket_fwd.png^[verticalframe:12:0",
  })

