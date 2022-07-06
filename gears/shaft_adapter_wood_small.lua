
local S = gear3d.translator

local _shaft_sides = {"front", "back"}
local _shaft_types = {front="steel",back="gear3d_small_wood"}
local _shaft_opposites = {back=true}

gear3d.register_machine("gear3d:shaft_adapter_wood_small_fwd",
  {
    -- machine def
	  node_description = S("Wood Small Shaft Adapter"),
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
    mesh = "gear3d_shaft_adapter_small.obj",
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
      "power_generators_frame_steel.png",
      "power_generators_shaft_steel.png",
      "power_generators_body_steel.png^gear3d_shaft_adapter_arrow_fwd.png",
      "gear3d_shaft_small.png^[verticalframe:12:0",
    },
  },{
    -- active node def
    tiles = {
      "power_generators_frame_steel.png",
      "power_generators_shaft_steel.png",
      "power_generators_body_steel.png^gear3d_shaft_adapter_arrow_fwd.png",
      {
        image = "gear3d_shaft_small_fwd.png",
        animation = {
          type = "vertical_frames",
          aspect_w = 48,
          aspect_h = 20,
          length = 1.
        },
      },
    },
  },{
    -- reverse node def
    tiles = {
      "power_generators_frame_steel.png",
      "power_generators_shaft_steel.png",
      "power_generators_body_steel.png^gear3d_shaft_adapter_arrow_fwd.png",
      {
        image = "gear3d_shaft_small.png",
        animation = {
          type = "vertical_frames",
          aspect_w = 48,
          aspect_h = 20,
          length = 1.
        },
      },
    },
  },{
    -- broken node def
    description = S("Broken Wood Small Shaft Adapter"),
    drawtype = "mesh",
    mesh = "gear3d_shaft_adapter_small.obj",
    selectionbox = {-0.5, -0.5, -0.25, 0.5, 0.5, 0.25},
    tiles = {
      "power_generators_frame_steel.png",
      "power_generators_shaft_steel.png",
      "power_generators_body_steel.png^gear3d_shaft_adapter_arrow_fwd.png",
      "gear3d_shaft_small.png^[verticalframe:12:0",
    },
  })

gear3d.register_machine("gear3d:shaft_adapter_wood_small_rev",
  {
    -- machine def
	  node_description = S("Wood Small Shaft Adapter (Reverse)"),
    node_help = S("Can be greased.").."\n"..S("Shaft type adapter."),
    
    input_stack_size = 0,
    have_input = false,
    use_stack_size = 0,
    have_usage = false,
    output_stack_size = 0,
    
    _shaft_sides = _shaft_sides,
    _shaft_types = _shaft_types,
    _friction = 0.0025,
    _I = 225,
    
    _rpm_deactivate = true,
    _qgrease_max = 2,
    _qgrease_eff = 1,
    
    get_formspec = function() return "" end
  },{
    -- node def
    drawtype = "mesh",
    mesh = "gear3d_shaft_adapter_small.obj",
    use_texture_alpha = "clip",
    paramtype2 = "facedir",
    selectionbox = {-0.5, -0.5, -0.25, 0.5, 0.5, 0.25},
    groups = {cracky = 2, shaft = 1, greasable = 1},
    
    _shaft_sides = _shaft_sides,
    _shaft_types = _shaft_types,
  },{
    -- inactive node def
    tiles = {
      "power_generators_frame_steel.png",
      "power_generators_shaft_steel.png",
      "power_generators_body_steel.png^gear3d_shaft_adapter_arrow_rev.png",
      "gear3d_shaft_small.png^[verticalframe:12:0",
    },
  },{
    -- active node def
    tiles = {
      "power_generators_frame_steel.png",
      "power_generators_shaft_steel.png",
      "power_generators_body_steel.png^gear3d_shaft_adapter_arrow_rev.png",
      {
        image = "gear3d_shaft_small.png",
        animation = {
          type = "vertical_frames",
          aspect_w = 48,
          aspect_h = 20,
          length = 1.
        },
      },
    },
  },{
    -- reverse node def
    tiles = {
      "power_generators_frame_steel.png",
      "power_generators_shaft_steel.png",
      "power_generators_body_steel.png^gear3d_shaft_adapter_arrow_rev.png",
      {
        image = "gear3d_shaft_small_fwd.png",
        animation = {
          type = "vertical_frames",
          aspect_w = 48,
          aspect_h = 20,
          length = 1.
        },
      },
    },
  },{
    -- broken node def
    description = S("Broken Wood Small Shaft Adapter"),
    drawtype = "mesh",
    mesh = "gear3d_shaft_adapter_small.obj",
    selectionbox = {-0.5, -0.5, -0.25, 0.5, 0.5, 0.25},
    tiles = {
      "power_generators_frame_steel.png",
      "power_generators_shaft_steel.png",
      "power_generators_body_steel.png^gear3d_shaft_adapter_arrow_rev.png",
      "gear3d_shaft_small.png^[verticalframe:12:0",
    },
  })

