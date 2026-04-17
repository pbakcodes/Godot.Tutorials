extends LevelParent

# Using load() instead of preload() to avoid circular dependency with outside.gd
var outside_level: PackedScene = load("res://scenes/levels/outside.tscn")

func _on_exit_gate_area_body_entered(_body: Node2D) -> void:
	var tween: Tween = create_tween()
	tween.tween_property($Player, "speed", 0, 0.5)
	TransitionLayer.fade_to_change_scene(outside_level)
