
local cards = {}

-- Function to create a card
local function new_card(myid, myname, mycost, mygraphic, myeffect)
	return {
		id = myid,
		name = myname,
		cost = mycost,
		graphic = mygraphic,
		effect = myeffect
	}
end

cards[1] = new_card(1, "The Nymph", 2, "enymph", "nymph")
cards[2] = new_card(2, "The Poison", 1, "epoison", "poison")
cards[3] = new_card(3, "The Comet", 1, "ecomet", "comet")
cards[4] = new_card(4, "The Prophecy", 2, "eprophecy", "prophecy")
cards[5] = new_card(5, "The Order", 1, "eorder", "order")
cards[6] = new_card(6, "The Devil", 1, "edevil", "devil")
cards[7] = new_card(7, "The Flight", 0, "eflight", "flight")
cards[8] = new_card(8, "The Witch", 2, "ewitch", "witch")
cards[9] = new_card(9, "The Fruit", 1, "efruit", "fruit")
cards[10] = new_card(10, "The Knight", 3, "eknight", "knight")
cards[11] = new_card(11, "The Sunrise", 0, "esunrise", "sunrise")
cards[12] = new_card(12, "The Eclipse", 0, "eeclipse", "eclipse")
cards[13] = new_card(13, "The Judgement", 1, "ejudgement", "judgement")
cards[14] = new_card(14, "The Mirror", 3, "emirror", "mirror")
cards[15] = new_card(15, "The Contract", 3, "econtract", "contract")

for k, v in pairs(cards) do
	print("cards[" .. tostring(k) .. "] -> id=" .. tostring(v.id) .. ", name=" .. tostring(v.name))
end

local effect_map = {
	nymph = function(targets)
		local player = targets.player
		player.hp = player.hp + 3
	end,
	
	poison = function(targets)
		local player = targets.player
		player.natkbuff = player.natkbuff + 2
	end,
	
	comet = function(targets)
		local player = targets.player
		player.skillbuff = player.skillbuff + 2
	end,
	
	prophecy = function(targets)
		msg.post("controller", "draw_cards", { amount = 2 })
	end,
	
	order = function(targets)
		local player = targets.player
		local enemy = targets.enemy
		player.hp = player.hp + 2
		enemy.hp = enemy.hp + 2
	end,
	
	devil = function(targets)
		msg.post("controller", "draw_cards", { amount = 2 })
	end,
	
	flight = function(targets)
		local player = targets.player
		if player.dice < player.max_dice then
			player.dice = player.dice + 2
		end
	end,
	
	witch = function(targets)
		local player = targets.player
		if player.dice < player.max_dice then
			player.dice = player.dice + 5
		end
	end,
	
	fruit = function(targets)
		local player = targets.player
		player.shield = player.shield + 2
	end,
	
	knight = function(targets)
		local player = targets.player
		player.shield = player.shield + 5
	end,
	
	sunrise = function(targets)
		local player = targets.player
		player.skillbuff = player.skillbuff + 1
		player.skillbd = 2
	end,
	
	eclipse = function(targets)
		local player = targets.player
		player.natkbuff = player.natkbuff + 1
		player.natkbd = 2
	end, 
	
	judgement = function(targets)
		local enemy = targets.enemy
		enemy.hp = enemy.hp-2
	end,
	
	mirror = function(targets)
		local player = targets.player
		local enemy = targets.enemy
		enemy.hp = player.hp
	end,
	
	contract = function(targets)
		local player = targets.player
		handsize = valuestored
		handsize = 0
		player.hp = player.hp + valuestored
	end,
}

-- When setting up the card, receive the card data
--function on_message(self, message_id, message, sender)
	--if message_id == hash("setup_card") then
		--local card_data = message.properties

		-- Look up the effect function using the card's effect name
		--local effect_function = effect_map[card_data.effect_key]
		--if effect_function then
			-- You can call the effect function now with appropriate targets
			--effect_function({ player = self.player, enemy = self.enemy })
		--else
			--print("Error: No effect function found for card", card_data.name)
		--end
	--end
--end

return cards
