extends CharacterBody2D

signal has_shoot_laser()
signal has_thrown_granade()

var can_laser: bool = true
var can_granade: bool = true

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	
	#input
	var direction = Input.get_vector("left", "right", "up", "down")
	
	#collision
	velocity = direction * 500
	move_and_slide()
	
	#laser shooting input
	if(Input.is_action_pressed("primary_action")) and can_laser:
		# randomly select marker for laser initial position		
		can_laser = false
		$LaserTimer.start()
		
		# emit laser position that will created
		has_shoot_laser.emit(selectRandomWeaponMarkerPosition())
		
	if(Input.is_action_pressed("secondary_action")) and can_granade:
		can_granade = false
		$GranadeTimer.start()
		
		#emit granade position that will be created
		has_thrown_granade.emit(selectRandomWeaponMarkerPosition())

func _on_laser_timer_timeout() -> void:
	can_laser = true

func _on_granade_timer_timeout() -> void:
	can_granade = true

func selectRandomWeaponMarkerPosition() -> Vector2:
	var selected_laser_marker: Marker2D = $LaserStartPosition.get_children().pick_random()
	return selected_laser_marker.global_position
