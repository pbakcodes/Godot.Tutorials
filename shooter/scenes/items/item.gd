extends Area2D

var rotation_speed: int = 2
var options: Array = ['laser', 'granade', 'health']
var type: String = options.pick_random()
var randomize_counter: int = 0
var direction: Vector2
var distance: int = randi_range(150, 250)

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
		
	#tween
	var target_pos = position + direction * distance
	var tween = create_tween()
	tween.set_parallel(true)
	tween.tween_property(self, "position", target_pos, 0.5)
	tween.tween_property(self, "scale", Vector2(1, 1), 0.3).from(Vector2(0, 0))


func _on_body_entered(_body: Node2D) -> void:
	if type == options[0]:
		Globals.laser_amount += 5
	if type == options[1]:
		Globals.granade_amount += 1
	if type == options[2]:
		Globals.health += 10
	queue_free()
