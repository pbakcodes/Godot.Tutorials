extends Node2D

var laser_scene: PackedScene = preload("res://scenes/projectiles/laser.tscn")
var granade_scene: PackedScene = preload("res://scenes/projectiles/granade.tscn")

func _on_gate_player_entered(body) -> void:
	print("player has entered gate")
	print(body)

func _on_player_has_shoot_laser(pos) -> void:
	var laser = laser_scene.instantiate()
	laser.position = pos
	$Projectiles.add_child(laser)

func _on_player_has_thrown_granade(pos) -> void:
	var granade = granade_scene.instantiate()
	granade.position = pos
	$Projectiles.add_child(granade)
