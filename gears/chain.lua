
-- find side shafts
function gear3d.sprocket_find_side_shafts(shafts, need_rpm_update, top_data, side_data)
  if side_data.shaft_type=="gear3d_chain" then
    local side = side_data.side
    local side_full_side = top_data.self._sprocket_full_side[side]
    if not side_full_side then
      return 
    end
    local side_pos = appliances.get_sides_pos(top_data.pos, top_data.node, side_full_side)
    local side_node = minetest.get_node(side_pos)
    local from_pos = side_data.side_pos
    local ratio = side_data.ratio
    local TPart = side_data.TPart
    local shaft_type = side_data.shaft_type
    local s_I = 0
    local s_F = 0
    --print("side "..side.." node: "..side_node.name.." from_pos: "..minetest.pos_to_string(top_data.pos).." side_pos: "..minetest.pos_to_string(side_pos))
    local shaft = minetest.get_item_group(side_node.name, "shaft")
    while ratio>0 do
      if shaft<=0 then
        break
      end
      local side_def = minetest.registered_nodes[side_node.name]
      local side_side = appliances.is_connected_to(side_pos, side_node, from_pos, side_def._shaft_sides)
      if not side_side then
        break
      end
      --print(side_side)
      --print(dump(side_def._shaft_types[side_side]))
      --print(shaft_type)
      if (side_def._shaft_types[side_side]~=shaft_type) then
        break
      end
      --print(shaft)
      local side_meta = minetest.get_meta(side_pos)
      if shaft==1 then
        break
      else
        s_I = s_I + side_meta:get_int("I")*ratio
        s_F = s_F + side_meta:get_float("fric")*ratio
        
        if side_def._shaft_rpm_update then
          local o_rpm_opposite = false
          if top_data._shaft_opposites and side_def._shaft_opposites then
            if not top_data._shaft_opposites[side] then
              o_rpm_opposite = true
            end
            if side_def._shaft_opposites[side_side] then
              o_rpm_opposite = not o_rpm_opposite
            end
          end
          --print("chain update "..minetest.pos_to_string(side_pos))
          table.insert(need_rpm_update, {
              meta = side_meta,
              pos = side_pos,
              node = side_node,
              ratio = ratio,
              rpm_opposite = o_rpm_opposite,
              rpm_update = side_def._shaft_rpm_update,
              
              side = side,
              side_side = side_side,
            })
        end
      end
      
      from_pos = side_pos
      local from_node = side_node
      shaft_type = side_def._shaft_types[appliances.opposite_side[side_side]]
      side_pos = appliances.get_side_pos(side_pos, side_node, appliances.opposite_side[side_side])
      side_node = minetest.get_node(side_pos)
      
      shaft = minetest.get_item_group(side_node.name, "shaft")
      if shaft<=0 then
        -- look to sides for sprocket wheel
        --print("look to sides from "..top_data.self.node_name_inactive)
        --print("side node: "..side_node.name.." side pos: "..minetest.pos_to_string(side_pos))
        for _,side2 in pairs({"left","right","bottom","top"}) do
          local wheel_pos = appliances.get_sides_pos(from_pos, from_node, {appliances.opposite_side[side_side],side2})
          local wheel_node = minetest.get_node(wheel_pos)
          --print("wheel test pos: "..minetest.pos_to_string(wheel_pos).." node: "..wheel_node.name)
          shaft = minetest.get_item_group(wheel_node.name, "shaft")
          if (shaft==1) then
            local wheel_def = minetest.registered_nodes[wheel_node.name]
            side_side = appliances.is_connected_to(wheel_pos, wheel_node, side_pos, wheel_def._shaft_sides)
            if (wheel_def._shaft_types[side_side]==shaft_type) then
              side_meta = minetest.get_meta(wheel_pos)
              
              local o_ratio = side_meta:get_float(side_side.."_ratio")
              if o_ratio==0 then
                break
              end
              local o_I = side_meta:get_int("Isum")
              local o_F = side_meta:get_int("fric")
              --local o_T = side_meta:get_int("T")
              local o_rpm = side_meta:get_int("L")/o_I
              ratio = ratio/o_ratio
              side_data.ratio = ratio
              local engine_side = top_data.meta:get_int(side.."_engine")
              local engine_side_side = side_meta:get_int(side_side.."_engine")
              
              local o_rpm_opposite = false
              if top_data._shaft_opposites and side_def._shaft_opposites then
                if not top_data._shaft_opposites[side] then
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
              
              --print("add wheel by side "..side_side.." on chain "..minetest.pos_to_string(wheel_pos))
              table.insert(shafts, {
                meta = side_meta,
                timer = minetest.get_node_timer(wheel_pos),
                ratio = ratio,
                I = o_I,
                rpm = o_rpm,
                rpm_opposite = o_rpm_opposite,
                engine_side = engine_side,
                engine_side_side = engine_side_side,
                side = side,
                side_side = side_side,
                
                --[[
                name = wheel_node.name,
                pos = wheel_pos,
                fric = o_F,
                side_TPart = TPart,
                --]]
              })
              if engine_side_side==0 then
                --print(string.format("Usum + s_I + o_I*ratio = %d + %d +%d*%f", Isum, s_I, o_I, ratio))
                top_data.Isum = top_data.Isum + s_I + o_I*ratio
                top_data.minT = top_data.minT + side_meta:get_int("minT")*ratio*TPart
                top_data.Fsum = top_data.Fsum + s_F + o_F*ratio*TPart
                top_data.powered_shafts = top_data.powered_shafts + 1
              else
                --Tpwr = Tpwr + o_T*ratio
                if top_data.rpmPwr>0 then
                  top_data.rpmPwr = math.min(rpmPwr, o_rpm/ratio)
                else
                  top_data.rpmPwr = o_rpm/ratio
                end
                top_data.rpmPwrSum = top_data.rpmPwrSum + o_rpm/ratio
              end
              return
            end
          end
          shaft = 0 -- like stop on end of for loop
        end
      end
      
      side_data.from_pos = from_pos
      side_data.shaft_type = shaft_type
      side_data.side_pos = side_pos
      side_data.side_node = side_node
    end
  else
    power_generators.default_find_side_shafts(shafts, need_rpm_update, top_data, side_data)
  end
end

