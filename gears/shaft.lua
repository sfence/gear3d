
local S = gear3d.translator

function gear3d.register_shaft(basename, machine_def, shared_def, inact_def, act_def, rev_def)
  minetest.register_node(basename, inact_def)
end
