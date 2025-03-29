extends LevelParent

var outside_level: PackedScene = load("res://scenes/levels/outside.tscn")

func _on_exit_gate_area_body_entered(_body: Node2D) -> void:
	var tween = create_tween()
	tween.tween_property($Player, "speed", 0, 0.5)
	call_deferred("change_scene", outside_level)
	
func change_scene(level: PackedScene) -> void:
	get_tree().change_scene_to_packed(level)
