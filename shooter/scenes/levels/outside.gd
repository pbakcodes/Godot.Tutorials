extends LevelParent

var inside_level: PackedScene = load("res://scenes/levels/inside.tscn")

func _on_gate_player_entered(_body) -> void:
	var tween = create_tween()
	tween.tween_property($Player, "speed", 0, 0.5)
	call_deferred("change_scene", inside_level)
	
func change_scene(level: PackedScene) -> void:
	get_tree().change_scene_to_packed(level)
