extends Sprite2D

var pos: Vector2 = Vector2.ZERO
const speed: int = 300
var test_scale: int = 1

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pos = Vector2(300, 200)
	position = pos

	test_scale = 2;
	scale = Vector2(test_scale, test_scale)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pos.x  += speed * delta
	position = pos
	
