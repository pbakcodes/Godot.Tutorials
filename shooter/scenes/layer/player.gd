extends CharacterBody2D

signal has_shoot_laser(pos, direction)
signal has_thrown_granade(pos, direction)

var can_laser: bool = true
var can_granade: bool = true

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	
	#input
	var direction = Input.get_vector("left", "right", "up", "down")
	
	#collision
	velocity = direction * 500
	move_and_slide()
	
	# rotation based on mouse position
	look_at(get_global_mouse_position())
	
	#store player direction
	var player_direction = (get_global_mouse_position() - position).normalized()
	
	#laser shooting input
	if(Input.is_action_pressed("primary_action")) and can_laser:
		# randomly select marker for laser initial position		
		can_laser = false
		$LaserTimer.start()
		
		#emit granade position with player direction towards mouse position
		var selected_laser_marker_position: Vector2 = $LaserStartPosition.get_children().pick_random().global_position
		has_shoot_laser.emit(selected_laser_marker_position, player_direction)
		
	if(Input.is_action_pressed("secondary_action")) and can_granade:
		can_granade = false
		$GranadeTimer.start()
		var marker_position = $LaserStartPosition/Marker2D1.global_position
		
		#emit granade position with player direction towards mouse position
		has_thrown_granade.emit(marker_position, player_direction)

func _on_laser_timer_timeout() -> void:
	can_laser = true

func _on_granade_timer_timeout() -> void:
	can_granade = true
