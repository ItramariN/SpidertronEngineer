function add_prerequisites(tech_name, require_names)
    if not data.raw.technology[tech_name] then return end
    if type(require_names) == "string" then require_names = {require_names} end
    for _, require_name in pairs(require_names) do
      if data.raw.technology[require_name] then
        data.raw.technology[tech_name].prerequisites = data.raw.technology[tech_name].prerequisites or {}
        local already = false
        for _, prerequisite in pairs(data.raw.technology[tech_name].prerequisites) do
          if prerequisite == require_name then
            already = true
            break
          end
        end
        if not already then
          table.insert(data.raw.technology[tech_name].prerequisites, require_name)
        end
      end
    end
  end
  
  
  function remove_prerequisites (prototype_name, prerequisites)
    local prototype = data.raw.technology[prototype_name]
    if not prototype then return end
    for _, new_prerequisite in pairs(prerequisites) do
      for i = #prototype.prerequisites, 1, -1 do
        if prototype.prerequisites[i] == new_prerequisite then
          table.remove(prototype.prerequisites, i)
        end
      end
    end
  end
  
  -- Remove heavy-armor, modular-armor
  data.raw.recipe["light-armor"]["enabled"] = false
  data.raw.technology["heavy-armor"] = nil
  data.raw.technology["modular-armor"] = nil
  
  data.raw.recipe["pistol"] = nil
  data.raw.recipe["submachine-gun"] = nil
  data.raw.recipe["shotgun"] = nil
  data.raw.recipe["flamethrower"] = nil
  data.raw.recipe["rocket-launcher"] = nil
  data.raw.recipe["combat-shotgun"] = nil
  
  
  -- Mil 1 gives heavy-armor, MG, Shotgun
  data.raw.technology["military"].effects = {
    {
      type = "give-item",
      item = "spidertron-engineer-1"
    },
    {
      type = "unlock-recipe",
      recipe = "shotgun-shell"
    },
  }
  
  -- Mil 2 gives modular-armor, rocket launcher, flamethrower
  table.insert(data.raw.technology["military-2"].effects, 1, {
    type = "give-item",
    item = "spidertron-engineer-2"
  })
  
  add_prerequisites("military-2", {"advanced-electronics"})
  remove_prerequisites("solar-panel-equipment", {"modular-armor"})
  remove_prerequisites("power-armor", {"modular-armor"})
  
  data.raw.technology["rocketry"].effects = {
    {
      type = "unlock-recipe",
      recipe = "rocket"
    }
  }
  
  add_prerequisites("rocketry", {"military-2"})
  
  data.raw.technology["flamethrower"].effects = {
    {
      type = "unlock-recipe",
      recipe = "flamethrower-ammo"
    },
    {
      type = "unlock-recipe",
      recipe = "flamethrower-turret"
    }
  }
  add_prerequisites("flamethrower", {"military-2"})
  
  
  -- Power Armor gives power-armor, combat-shotgun, second rocket slot
  data.raw.technology["power-armor"].effects = {
    {
      type = "give-item",
      item = "spidertron-engineer-3"
    },
  }
  add_prerequisites("power-armor", {"military-2"})
  
  
  -- Power Armor 2 gives power-armor-mk2, 3rd rocket slot
  data.raw.technology["power-armor-mk2"].effects = {
    {
      type = "give-item",
      item = "spidertron-engineer-4"
    },
  }
  
  data.raw.technology["military-3"].effects = {
    {
      type = "unlock-recipe",
      recipe = "poison-capsule"
    },
    {
      type = "unlock-recipe",
      recipe = "slowdown-capsule"
    },
  }
  
  
  -- Spidertron gives MK6
  table.insert(data.raw.technology["spidertron"].effects, 1,{
    type = "give-item",
    item = "spidertron-engineer-5"
  })
  add_prerequisites("spidertron", {"power-armor-mk2"})