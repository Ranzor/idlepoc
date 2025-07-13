extends Node

var coins: float = 0.0
var coins_per_second: float = 1.0
var farm_level: int = 1

const BASE_COST := 5.0
const COST_MULTIPLIER := 1.15
const BASE_INCOME := 1.0
const INCOME_MULTIPLIER := 1.10

func _process(delta):
	coins += coins_per_second * delta

func upgrade_farm():
	var max_levels = get_max_affordable_upgrades()
	if max_levels < 1:
		return
	var cost = get_total_upgrade_cost(max_levels)
	coins -= cost
	farm_level += max_levels
	coins_per_second = BASE_INCOME * pow(INCOME_MULTIPLIER, farm_level)
func get_farm_upgrade_cost() -> float:
	return BASE_COST * pow(COST_MULTIPLIER, farm_level)

func get_total_upgrade_cost(levels: int) -> float:
	if levels == 0:
		return 0.0
	var r = COST_MULTIPLIER
	var a = BASE_COST * pow(r, farm_level)
	return a * ((pow(r, levels) - 1) / (r - 1))

func get_max_affordable_upgrades() -> int:
	var r = COST_MULTIPLIER
	var a = BASE_COST * pow(r, farm_level)
	var n = 0
	while true:
		var total_cost = a * ((pow(r, n + 1) - 1) / (r - 1))
		if total_cost > coins:
			break
		n += 1
	return n
