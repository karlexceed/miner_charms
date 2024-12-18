-- miner_charms


-- Load support for MT game translation.
local S = core.get_translator(core.get_current_modname())


-- Define the effects
local old_handle_node_drops = core.handle_node_drops


core.handle_node_drops = function(pos, drops, digger)
	-- Check drops
	for k, name in pairs(drops) do
		-- Is it stone?
		if core.get_item_group(name, "stone") > 0 then
			-- Is the player holding the Repel Stone charm?
			local inv = digger:get_inventory()
			
			if inv:contains_item("main", "miner_charms:repel_stone") then
				local playername = digger:get_player_name()
				
				-- Don't pick up the node!
				drops[k] = nil
				local handle = core.sound_play({name = "miner_charms_vaporize"},{to_player = playername})
			end
		end
		
		-- Is it crumbly?
		if core.get_item_group(name, "crumbly") > 0 then
			-- Is the player holding the Crumbly Repel charm?
			local inv = digger:get_inventory()
			
			if inv:contains_item("main", "miner_charms:repel_crumbly") then
				local playername = digger:get_player_name()
				
				-- Don't pick up the node!
				drops[k] = nil
				local handle = core.sound_play({name = "miner_charms_vaporize"},{to_player = playername})
			end
		end
	end
	
	return old_handle_node_drops(pos, drops, digger)
end


-- Define the charms
-- Repel Stone
core.register_craftitem("miner_charms:repel_stone", {
    description = "A charm that repels stone.",
	short_description = "Stone Repel Charm",
    inventory_image = "coin_1_16.png",
	wield_scale = {x = 0.5, y = 0.5, z = 0.5},
	stack_max = 1,
	light_source = 1
})


core.register_craft({
    type = "shaped",
    output = "miner_charms:repel_stone",
    recipe = {
        {"group:stone", "default:gold_ingot", "group:stone"},
        {"default:gold_ingot", "default:diamond", "default:gold_ingot"},
        {"group:stone", "default:gold_ingot", "group:stone"}
    }
})


-- Repel Dirt, Gravel. and Sand
core.register_craftitem("miner_charms:repel_crumbly", {
    description = "A charm that repels dirt, gravel, and sand.",
	short_description = "Crumbly Repel Charm",
    inventory_image = "coin_2_16.png",
	wield_scale = {x = 0.5, y = 0.5, z = 0.5},
	stack_max = 1,
	light_source = 1
})


core.register_craft({
    type = "shaped",
    output = "miner_charms:repel_crumbly",
    recipe = {
        {"group:crumbly", "default:gold_ingot", "group:crumbly"},
        {"default:gold_ingot", "default:diamond", "default:gold_ingot"},
        {"group:crumbly", "default:gold_ingot", "group:crumbly"}
    }
})
