extends Area2D

var speed: int = Constants.LASER_SPEED
var direction: Vector2 = Vector2.UP

func _ready() -> void:
	$DestroyTimer.start()

func _process(delta: float) -> void:
	position += direction * speed * delta

func _on_body_entered(body: Node2D) -> void:
	if body.has_method("hit"):
		body.hit(Constants.LASER_DAMAGE)
		queue_free()

func _on_destroy_timer_timeout() -> void:
	queue_free()
