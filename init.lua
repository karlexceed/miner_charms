-- miner_runes

-- Load support for MT game translation.
local S = minetest.get_translator(minetest.get_current_modname())

-- Define the effects
local old_handle_node_drops = minetest.handle_node_drops

minetest.handle_node_drops = function(pos, drops, digger)
	local inv = digger:get_inventory()
	
	-- Check player inventory for rune
	if inv:contains_item("main", "miner_runes:repel_stone") then
		local playername = digger:get_player_name()
		
		-- Check oldnode's group for stone
		for k, name in pairs(drops) do
			if minetest.get_item_group(name, "stone") > 0 then
				-- Don't pick up the node!
				drops[k] = nil
				local handle = minetest.sound_play({name = "miner_runes_vaporize"},{to_player = playername})
			end
		end
	end
	
	return old_handle_node_drops(pos, drops, digger)
end

-- Define the object
minetest.register_craftitem("miner_runes:repel_stone", {
    description = "Stone repelling rune",
    inventory_image = "miner_runes_jeran_16.png"
})

minetest.register_craft({
    type = "shaped",
    output = "miner_runes:repel_stone",
    recipe = {
        {"group:stone", "", "group:stone"},
        {"", "group:soil", ""},
        {"group:stone", "", "group:stone"}
    }
})