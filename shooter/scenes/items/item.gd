extends Area2D

var rotation_speed: int = 2
var options: Array = ['laser', 'granade', 'health']
var type: String = options.pick_random()
var randomize_counter: int = 0

var blue: Color = Color(0.1, 0.2, 0.8)
var red: Color = Color(0.8, 0.2, 0.1)
var green: Color = Color(0.1, 0.8, 0.1)

func _process(delta):
	rotation += rotation_speed * delta

func pick_random_type() -> String:
	var result = ''
	var attempts = 0
	while attempts < 3:
		result = options.pick_random()
		if result == options[0]:
			break
		attempts += 1
	return result
	
	
func _ready() -> void:
	#reroll option if not laser to make it more often
	type = pick_random_type()
	
	#Set item properties
	if type == options[0]:
		$Sprite2D.modulate = blue
	if type == options[1]:
		$Sprite2D.modulate = red
	if type == options[2]:
		$Sprite2D.modulate = green


func _on_body_entered(body: Node2D) -> void:
	body.add_item(type)
	queue_free()
