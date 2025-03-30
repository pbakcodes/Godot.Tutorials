extends Node2D

class_name LevelParent

var laser_scene: PackedScene = preload("res://scenes/projectiles/laser.tscn")
var granade_scene: PackedScene = preload("res://scenes/projectiles/granade.tscn")

func _on_player_has_shoot_laser(pos, direction) -> void:
	var laser = laser_scene.instantiate() as Area2D
	laser.position = pos
	laser.rotation_degrees = rad_to_deg(direction.angle()) + 90
	laser.direction = direction
	$Projectiles.add_child(laser)
	$UI.update_laser_text() 

func _on_player_has_thrown_granade(pos, direction) -> void:
	var granade = granade_scene.instantiate() as RigidBody2D
	granade.position = pos
	granade.linear_velocity = direction * granade.speed
	$Projectiles.add_child(granade)
	$UI.update_granade_text()

func _on_house_player_entered() -> void:
	var tween = create_tween()
	tween.tween_property($Player/Camera2D, "zoom", Vector2(1, 1), 1)

func _on_house_player_exited() -> void:
	var tween = create_tween()
	tween.tween_property($Player/Camera2D, "zoom", Vector2(0.6, 0.6), 2)


func _on_player_update_stats() -> void:
	$UI.update_laser_text()
	$UI.update_granade_text()
