extends RigidBody2D

var speed: int = 500
var direction: Vector2 = Vector2.UP

func _process(delta: float) -> void:
	position += direction * speed * delta
