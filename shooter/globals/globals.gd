extends Node

signal stat_change
var player_position: Vector2

var laser_amount: int = 20:
	set(value):
		laser_amount = value
		stat_change.emit()

var granade_amount: int = 5:
	set(value):
		granade_amount = value
		stat_change.emit()

var player_can_be_damaged: bool = true
var health: int = 60:
	set(value):
		if value > health:
			health = min(value, 100)
		else:
			if player_can_be_damaged:
				health = value
				player_can_be_damaged = false
				player_immune_timer()
		stat_change.emit()
			
func player_immune_timer() -> void:
	await get_tree().create_timer(0.5).timeout
	player_can_be_damaged = true
