extends CharacterBody2D

signal has_shoot_laser(pos: Vector2, direction: Vector2)
signal has_thrown_grenade(pos: Vector2, direction: Vector2)

var can_laser: bool = true
var can_grenade: bool = true
var can_be_damaged: bool = true

@export var max_speed: int = 500
var speed: int = max_speed

func hit(damage: int = Constants.LASER_DAMAGE) -> void:
	if can_be_damaged:
		Globals.health -= damage
		can_be_damaged = false
		_start_immune_timer()

func _start_immune_timer() -> void:
	await get_tree().create_timer(Constants.PLAYER_IMMUNE_DURATION).timeout
	can_be_damaged = true

func _process(_delta: float) -> void:
	var input_direction: Vector2 = Input.get_vector("left", "right", "up", "down")

	velocity = input_direction * speed
	move_and_slide()

	Globals.player_position = global_position
	look_at(get_global_mouse_position())

	var aim_direction: Vector2 = (get_global_mouse_position() - position).normalized()

	if Input.is_action_pressed("primary_action") and can_laser and Globals.laser_amount > 0:
		Globals.laser_amount -= 1
		$GPUParticles2D.emitting = true
		can_laser = false
		$LaserTimer.start()
		var laser_pos: Vector2 = $LaserStartPosition.get_children().pick_random().global_position
		has_shoot_laser.emit(laser_pos, aim_direction)

	if Input.is_action_pressed("secondary_action") and can_grenade and Globals.grenade_amount > 0:
		Globals.grenade_amount -= 1
		can_grenade = false
		$GrenadeTimer.start()
		var marker_position: Vector2 = $LaserStartPosition/Marker2D1.global_position
		has_thrown_grenade.emit(marker_position, aim_direction)

func _on_laser_timer_timeout() -> void:
	can_laser = true

func _on_grenade_timer_timeout() -> void:
	can_grenade = true
