extends CharacterBody2D

var direction: Vector2 = Vector2.RIGHT
var speed: int = 500
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	velocity = direction * speed
	move_and_slide()

func hit() -> void:
	print('damage')
