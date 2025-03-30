extends CanvasLayer

func fade_to_change_scene(target: PackedScene) -> void:
	$AnimationPlayer.play("fade_to_black")
	await $AnimationPlayer.animation_finished
	call_deferred("change_scene", target)
	$AnimationPlayer.play("reveal")

func change_scene(target: PackedScene) -> void:
	get_tree().change_scene_to_packed(target)
