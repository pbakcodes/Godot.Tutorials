extends Area2D

var speed: int = 5000
var direction: Vector2 = Vector2.UP

func _process(delta: float) -> void:
	position += direction * speed * delta
