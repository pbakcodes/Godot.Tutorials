extends CharacterBody2D

var player_nearby: bool = false
signal laser(pos, direction)
var can_laser: bool = true
var right_gun_use: bool = true

func _process(_delta):
	if player_nearby: 
		look_at(Globals.player_position)
		if can_laser:
			right_gun_use = not right_gun_use
			var pos: Vector2 = $LaserSpawnPositions.get_child(right_gun_use).global_position
			var direction: Vector2 = (Globals.player_position - position).normalized()
			laser.emit(pos, direction)
			can_laser = false
			$LaserCooldown.start()

func _on_attack_area_body_entered(_body: Node2D) -> void:
	player_nearby = true

func _on_attack_area_body_exited(_body: Node2D) -> void:
	player_nearby = false

func _on_laser_cooldown_timeout():
	can_laser = true
	
