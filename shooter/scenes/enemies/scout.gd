extends CharacterBody2D

var player_nearby: bool = false
signal laser(pos: Vector2, direction: Vector2)
var can_laser: bool = true
var can_be_damaged: bool = true
var right_gun_use: bool = true
var health: int = Constants.SCOUT_HEALTH

func hit(damage: int = Constants.LASER_DAMAGE) -> void:
	if can_be_damaged:
		health -= damage
		can_be_damaged = false
		$Timers/HitTimer.start()
		$Sprite2D.material.set_shader_parameter("progress", 1)
	if health <= 0:
		queue_free()

func _process(_delta: float) -> void:
	if player_nearby:
		look_at(Globals.player_position)
		if can_laser:
			right_gun_use = not right_gun_use
			var pos: Vector2 = $LaserSpawnPositions.get_child(int(right_gun_use)).global_position
			var dir: Vector2 = (Globals.player_position - position).normalized()
			laser.emit(pos, dir)
			can_laser = false
			$Timers/LaserCooldown.start()

func _on_attack_area_body_entered(_body: Node2D) -> void:
	player_nearby = true

func _on_attack_area_body_exited(_body: Node2D) -> void:
	player_nearby = false

func _on_laser_cooldown_timeout() -> void:
	can_laser = true

func _on_hit_timer_timeout() -> void:
	can_be_damaged = true
	$Sprite2D.material.set_shader_parameter("progress", 0)
