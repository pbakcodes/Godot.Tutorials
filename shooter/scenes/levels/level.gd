extends Node2D

var test_array: Array[String] = ["Test", "Hello", "Stuff"]
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$Logo.rotation_degrees = 90;

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	
	$Logo.rotation_degrees += 300 * delta
		
	if ($Logo.position.x > 1000):
		$Logo.pos = Vector2.ZERO

func test_function() -> void:
	print('this is a test function in level node')
