extends Control

@export var level: Label
@export var cps: Label
@export var label: Label
@export var button: Button

func _on_button_pressed():
	Game.upgrade_farm()

func _process(_delta):
	label.text = "Coins: %.2f" % Game.coins
	var max_levels = Game.get_max_affordable_upgrades()
	var cost = Game.get_total_upgrade_cost(max_levels)
	cps.text = "Coins per second: %.2f" % Game.coins_per_second
	level.text = "Level: %d" % Game.farm_level

	if max_levels == 0:
		button.disabled = true
		button.text = "Buy 1 levels (Cost: %.2f)" % Game.get_farm_upgrade_cost()
	else:
		button.text = "Buy %d levels (Cost: %.2f)" % [max_levels, cost] 
		button.disabled = false
