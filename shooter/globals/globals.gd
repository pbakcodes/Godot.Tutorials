extends Node

signal stat_change
signal player_died

var player_position: Vector2

var laser_amount: int = 20:
	set(value):
		laser_amount = value
		stat_change.emit()

var grenade_amount: int = 5:
	set(value):
		grenade_amount = value
		stat_change.emit()

var health: int = 60:
	set(value):
		health = clampi(value, 0, Constants.MAX_HEALTH)
		stat_change.emit()
		if health <= 0:
			player_died.emit()

func reset() -> void:
	laser_amount = 20
	grenade_amount = 5
	health = 60
