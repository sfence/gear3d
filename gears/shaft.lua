
local S = gear3d.translator

local function update_def(shared_def, specific_def)
  local node_def_specific = table.copy(shared_def)
  for key, value in pairs(specific_def) do
    node_def_specific[key] = value
  end
  return node_def_specific
end

function gear3d.register_shaft(basename, shared_def, inact_def, fwd_def, rev_def)
  local fwdname = basename.."_fwd"
  local revname = basename.."_rev"
  shared_def = table.copy(shared_def)
  shared_def.drop = basename
  shared_def._shaft_rpm_update = function(shaft, new_rpm)--, rpmPwr)
      if (new_rpm==0) then
        appliances.swap_node(shaft.pos, basename)
      else
        --print(dump(shaft))
        if new_rpm<0 then
          appliances.swap_node(shaft.pos, revname)
        else
          appliances.swap_node(shaft.pos, fwdname)
        end
      end
    end
  minetest.register_node(basename, update_def(shared_def, inact_def))
  minetest.register_node(fwdname, update_def(shared_def, fwd_def))
  minetest.register_node(revname, update_def(shared_def, rev_def))
end
