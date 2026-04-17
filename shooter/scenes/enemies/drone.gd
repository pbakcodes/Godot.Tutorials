extends CharacterBody2D

var health: int = Constants.DRONE_HEALTH
var can_be_damaged: bool = true
var speed: int = Constants.DRONE_SPEED
var patrol_direction: Vector2 = Vector2.RIGHT

func hit(damage: int = Constants.LASER_DAMAGE) -> void:
	if can_be_damaged:
		health -= damage
		can_be_damaged = false
		$DroneImage.modulate = Color.RED
		_start_hit_cooldown()
	if health <= 0:
		queue_free()

func _start_hit_cooldown() -> void:
	await get_tree().create_timer(0.3).timeout
	if is_inside_tree():
		can_be_damaged = true
		$DroneImage.modulate = Color.WHITE

func _process(_delta: float) -> void:
	var distance_to_player: float = global_position.distance_to(Globals.player_position)

	if distance_to_player < Constants.DRONE_DETECTION_RANGE:
		var chase_direction: Vector2 = (Globals.player_position - global_position).normalized()
		velocity = chase_direction * speed
		look_at(Globals.player_position)
	else:
		velocity = patrol_direction * speed

	move_and_slide()

	if get_slide_collision_count() > 0:
		patrol_direction = patrol_direction.rotated(PI / 2)
