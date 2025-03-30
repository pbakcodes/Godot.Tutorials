extends Node2D

class_name LevelParent

var laser_scene: PackedScene = preload("res://scenes/projectiles/laser.tscn")
var granade_scene: PackedScene = preload("res://scenes/projectiles/granade.tscn")
var item_scene: PackedScene = preload("res://scenes/items/item.tscn")

func _ready() -> void:
	for container in get_tree().get_nodes_in_group('Container'):
		container.connect("open", _on_container_opened)
		
	for scout in get_tree().get_nodes_in_group('Scouts'):
		scout.connect("laser", _on_scout_laser)
		
func _on_container_opened(pos, direction) -> void:
	var item = item_scene.instantiate()
	item.position = pos
	item.direction = direction
	$Items.call_deferred("add_child", item)
	
func _on_scout_laser(pos, direction) -> void:
	create_laser(pos, direction)

func _on_player_has_shoot_laser(pos, direction) -> void:
	create_laser(pos, direction)
	
func create_laser(pos, direction) -> void:
	var laser = laser_scene.instantiate() as Area2D
	laser.position = pos
	laser.rotation_degrees = rad_to_deg(direction.angle()) + 90
	laser.direction = direction
	$Projectiles.add_child(laser)
		
func _on_player_has_thrown_granade(pos, direction) -> void:
	var granade = granade_scene.instantiate() as RigidBody2D
	granade.position = pos
	granade.linear_velocity = direction * granade.speed
	$Projectiles.add_child(granade)
