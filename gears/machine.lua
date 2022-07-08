
local S = gear3d.translator

function gear3d.register_machine(basename, machine_def, shared_def, inact_def, act_def, rev_def, broken_def)
  machine_def.node_name_inactive = basename..""
  machine_def.node_name_active = basename.."_fwd"
  machine_def.node_name_reverse = basename.."_rev"
  if broken_def then
    machine_def.node_name_broken = basename.."_broken"
  end
  machine_def.__node_def_rev = rev_def
  local gear_machine = appliances.appliance:new(machine_def)
  
  gear_machine:power_data_register(
    {
      ["time_power"] = {
        run_speed = 1,
      },
    })
  
  function gear_machine:cb_on_construct(pos)
    local meta = minetest.get_meta(pos)
    meta:set_string(self.meta_infotext, self.node_description)
    
    meta:set_int("I", self._I)
    meta:set_int("Isum", self._I)
    for _,side in pairs(self._shaft_sides) do
      meta:set_int(side.."_ratio", 1)
    end
    self:call_on_construct(pos, meta)
  end
  
  function gear_machine:running(pos, meta)
    local L = meta:get_int("L")
    if (L>0) then
      appliances.swap_node(pos, self.node_name_active)
    elseif (L<0) then
      appliances.swap_node(pos, self.node_name_reverse)
    else
      appliances.swap_node(pos, self.node_name_inactive)
    end
    self:power_need(pos, meta)
    meta:set_string(self.meta_infotext, self:get_infotext(pos, meta, "running"))
    self:call_running(pos, meta)
    self:cb_running(pos, meta)
    self:update_state(pos, meta, "running")
  end
  
  function gear_machine:cb_after_update_node_active_def(node_def)
    local node_def_rev = table.copy(node_def)
    if self.__node_def_rev then
      for key, value in pairs(self.__node_def_rev) do
        node_def_rev[key] = value
      end
    end
    minetest.register_node(self.node_name_reverse, node_def_rev)
  end
  
  function gear_machine:get_infotext(_, _, state)
    if state=="running" then
      return self.node_description.." - "..S("working")
    else
      return self.node_description.." - "..appliances.state_infotexts[state]
    end
  end
  
  function gear_machine:cb_on_production(timer_step)
    power_generators.shaft_step(self, timer_step.pos, timer_step.meta, timer_step.use_usage)
  end
  
  function gear_machine:cb_waiting(pos, meta)
    power_generators.shaft_step(self, pos, meta, nil)
  end
  
  function gear_machine:shaft_break(pos, node, meta)
    -- make a sound, change node
    print("Shaft node "..(node.name).." break!")
  end
  
  gear_machine:register_nodes(shared_def, inact_def, act_def)
  
  if broken_def then
    minetest.register_node(gear_machine.node_name_broken, broken_def)
  end
end

