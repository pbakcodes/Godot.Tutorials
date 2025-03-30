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

var health: int = 60:
	set(value):
		health = value
		stat_change.emit()
