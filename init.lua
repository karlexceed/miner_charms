-- miner_runes

-- Load support for MT game translation.
local S = minetest.get_translator(minetest.get_current_modname())

-- Define the effects
local old_handle_node_drops = minetest.handle_node_drops

minetest.handle_node_drops = function(pos, drops, digger)
	-- Check drops
	for k, name in pairs(drops) do
		-- Is it stone?
		if minetest.get_item_group(name, "stone") > 0 then
			-- Is the player holding the Repel Stone rune?
			local inv = digger:get_inventory()
			
			if inv:contains_item("main", "miner_runes:repel_stone") then
				local playername = digger:get_player_name()
				
				-- Don't pick up the node!
				drops[k] = nil
				local handle = minetest.sound_play({name = "miner_runes_vaporize2"},{to_player = playername})
			end
		end
		
		-- Is it crumbly?
		if minetest.get_item_group(name, "crumbly") > 0 then
			-- Is the player holding the Repel Crumbly rune?
			local inv = digger:get_inventory()
			
			if inv:contains_item("main", "miner_runes:repel_crumbly") then
				local playername = digger:get_player_name()
				
				-- Don't pick up the node!
				drops[k] = nil
				local handle = minetest.sound_play({name = "miner_runes_vaporize2"},{to_player = playername})
			end
		end
	end
	
	return old_handle_node_drops(pos, drops, digger)
end


-- Define the objects
-- Repel Stone rune
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

-- Repel Dirt, Sand, and Gravel Rune
minetest.register_craftitem("miner_runes:repel_crumbly", {
    description = "Dirt, sand, and gravel repelling rune",
    inventory_image = "miner_runes_haglaz_16.png"
})

minetest.register_craft({
    type = "shaped",
    output = "miner_runes:repel_crumbly",
    recipe = {
        {"group:crumbly", "", "group:crumbly"},
        {"", "group:stone", ""},
        {"group:crumbly", "", "group:crumbly"}
    }
})
