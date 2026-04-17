extends LevelParent

# Using load() instead of preload() to avoid circular dependency with inside.gd
var inside_level: PackedScene = load("res://scenes/levels/inside.tscn")

func _on_gate_player_entered(_body: Variant) -> void:
	var tween: Tween = create_tween()
	tween.tween_property($Player, "speed", 0, 0.5)
	TransitionLayer.fade_to_change_scene(inside_level)

func _on_house_player_entered() -> void:
	var tween: Tween = create_tween()
	tween.tween_property($Player/Camera2D, "zoom", Vector2(1, 1), 1).set_trans(Tween.TRANS_QUAD)

func _on_house_player_exited() -> void:
	var tween: Tween = create_tween()
	tween.tween_property($Player/Camera2D, "zoom", Vector2(0.6, 0.6), 2)
