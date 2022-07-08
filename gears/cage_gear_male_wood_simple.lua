
local S = gear3d.translator

local _shaft_sides = {"front", "back", "top","bottom","right","left"}
local _shaft_types = {front="gear3d_small_wood",back="gear3d_small_wood",top="gear3d_cage_male_single",bottom="gear3d_cage_male_single",right="gear3d_cage_male_single",left="gear3d_cage_male_single"}
local _shaft_opposites = {back=true,bottom=true,left=true}

local function cage_find_side_shafts(shafts, need_rpm_update, top_data, side_data)
  if side_data.shaft_type=="gear3d_cage_male_single" then
    -- special side code
    local side = side_data.side
    local side_pos = side_data.side_pos
    local side_node = side_data.side_node
    local from_pos = side_data.from_pos
    local TPart = side_data.TPart
    local shaft_type = side_data.shaft_type
    local s_I = 0
    local s_F = 0
    --print("side "..side.." node: "..dump(side_node))
    local shaft = minetest.get_item_group(side_node.name, "shaft")
    if shaft<=0 then
      return
    end
    local side_def = minetest.registered_nodes[side_node.name]
    local side_side = appliances.is_connected_to(side_pos, side_node, from_pos, side_def._shaft_sides)
    if not side_side then
      return
    end
    if (side_def._shaft_types[side_side]~="gear3d_cage_male_single") then
      return
    end
    local side_meta = minetest.get_meta(side_pos)
    if shaft==1 then
      local o_I = side_meta:get_int("Isum")
      local o_F = side_meta:get_int("fric")
      --local o_T = side_meta:get_int("T")
      local o_rpm = side_meta:get_int("L")/o_I
      local engine_side = top_data.meta:get_int(side.."_engine")
      local engine_side_side = side_meta:get_int(side_side.."_engine")
      
      local o_rpm_opposite = false
      if top_data._shaft_opposites and side_def._shaft_opposites then
        --if not top_data._shaft_opposites[side] then
        if top_data._shaft_opposites[side] then
          o_rpm_opposite = true
        end
        if side_def._shaft_opposites[side_side] then
          o_rpm_opposite = not o_rpm_opposite
        end
        if o_rpm_opposite then
          if (top_data.rpm>0) and (o_rpm>0) then
            top_data.rpm_opposite = true
          elseif (top_data.rpm<0) and (o_rpm<0) then
            top_data.rpm_opposite = true
          end
        else
          if (top_data.rpm>0) then
          if (top_data.rpm>0) and (o_rpm<0) then
            top_data.rpm_opposite = true
          elseif (top_data.rpm<0) and (o_rpm>0) then
            top_data.rpm_opposite = true
          end
          end
        end
      end
      o_rpm = math.abs(o_rpm)
      
      table.insert(shafts, {
        meta = side_meta,
        timer = minetest.get_node_timer(side_pos),
        ratio = 1,
        I = o_I,
        rpm = o_rpm,
        rpm_opposite = o_rpm_opposite,
        engine_side = engine_side,
        engine_side_side = engine_side_side,
        side = side,
        side_side = side_side,
        
        --[[
        name = side_node.name,
        fric = o_F,
        side_TPart = TPart,
        --]]
      })
      if engine_side_side==0 then
        --print(string.format("Usum + s_I + o_I*ratio = %d + %d +%d*%f", Isum, s_I, o_I, ratio))
        top_data.Isum = top_data.Isum + s_I + o_I*1
        top_data.minT = top_data.minT + side_meta:get_int("minT")*1*TPart
        top_data.Fsum = top_data.Fsum + s_F + o_F*1*TPart
        top_data.powered_shafts = top_data.powered_shafts + 1
      else
        --Tpwr = Tpwr + o_T*ratio
        if top_data.rpmPwr>0 then
          top_data.rpmPwr = math.min(top_data.rpmPwr, o_rpm/1)
        else
          top_data.rpmPwr = o_rpm/1
        end
        top_data.rpmPwrSum = top_data.rpmPwrSum + o_rpm/1
      end
    end
  else
    power_generators.default_find_side_shafts(shafts, need_rpm_update, top_data, side_data)
  end
end

gear3d.register_machine("gear3d:cage_gear_male_wood_single",
  {
    -- machine def
	  node_description = S("Wood Single Male Cage Gear"),
    node_help = S("Can be greased."),
    
    input_stack_size = 0,
    have_input = false,
    use_stack_size = 0,
    have_usage = false,
    output_stack_size = 0,
    
    _shaft_sides = _shaft_sides,
    _shaft_types = _shaft_types,
    _shaft_opposites = _shaft_opposites,
    _shaft_find_side_shafts = cage_find_side_shafts,
    _friction = 0.0025,
    _I = 225,
    
    _rpm_deactivate = true,
    _qgrease_max = 2,
    _qgrease_eff = 1,
    
    get_formspec = function() return "" end
  },{
    -- node def
    drawtype = "mesh",
    mesh = "gear3d_cage_male_single.obj",
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
      "gear3d_cage_male_single_fwd.png^[verticalframe:24:0",
    },
  },{
    -- active node def
    tiles = {
      {
        image = "gear3d_cage_male_single_fwd.png",
        animation = {
          type = "vertical_frames",
          aspect_w = 192,
          aspect_h = 20,
          length = 2.
        },
      },
    },
  },{
    -- reverse node def
    tiles = {
      {
        image = "gear3d_cage_male_single_rev.png",
        animation = {
          type = "vertical_frames",
          aspect_w = 192,
          aspect_h = 20,
          length = 2.
        },
      },
    },
  },{
    -- broken node def
    description = S("Broken Wood Single Male Cage Gear"),
    drawtype = "mesh",
    mesh = "gear3d_cage_male_single.obj",
    selectionbox = {-0.5, -0.5, -0.25, 0.5, 0.5, 0.25},
    tiles = "gear3d_cage_male_single_fwd.png^[verticalframe:24:1",
  })


