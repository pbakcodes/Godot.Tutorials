extends CharacterBody2D

var can_laser: bool = true
var can_granade: bool = true

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	
	#input
	var direction = Input.get_vector("left", "right", "up", "down")
	
	#collision
	velocity = direction * 500
	move_and_slide()
	
	#laser shooting input
	if(Input.is_action_pressed("primary_action")) and can_laser:
		print('shoot laser')
		can_laser = false
		$LaserTimer.start()
		
	if(Input.is_action_pressed("secondary_action")) and can_granade:
		print('granade')
		can_granade = false
		$GranadeTimer.start()

func _on_laser_timer_timeout() -> void:
	can_laser = true

func _on_granade_timer_timeout() -> void:
	can_granade = true
