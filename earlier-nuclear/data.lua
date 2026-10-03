local function remove_from(list, value)
  if not list then return end
  for i, entry in ipairs(list) do
    if entry == value then
      table.remove(list, i)
      return true
    end
  end
  return false
end

local function remove_ingredient(ingredients, name)
  if not ingredients then return end
  for i, ingredient in ipairs(ingredients) do
    if ingredient[1] == name or ingredient.name == name then
      table.remove(ingredients, i)
      return true
    end
  end
  return false
end

local function replace_prerequisite(technology, old, new)
  if not technology.prerequisites then return end
  for i, prerequisite in ipairs(technology.prerequisites) do
    if prerequisite == old then
      technology.prerequisites[i] = new
      return true
    end
  end
  return false
end

local function get_technology(name)
  local technology = data.raw.technology[name]
  if not technology then
    log("[earlier-nuclear] technology not found: " .. name)
  end
  return technology
end

local kovarex = get_technology("kovarex-enrichment-process")
if kovarex then
  remove_from(kovarex.prerequisites, "production-science-pack")
  remove_ingredient(kovarex.unit.ingredients, "production-science-pack")
end

local reprocessing = get_technology("nuclear-fuel-reprocessing")
if reprocessing then
  remove_from(reprocessing.prerequisites, "production-science-pack")
  remove_ingredient(reprocessing.unit.ingredients, "production-science-pack")
end

local atomic_bomb = get_technology("atomic-bomb")
if atomic_bomb then
  replace_prerequisite(atomic_bomb, "military-4", "military-3")
  remove_ingredient(atomic_bomb.unit.ingredients, "utility-science-pack")
end
