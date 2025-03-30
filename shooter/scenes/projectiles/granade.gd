extends RigidBody2D

const speed: int = 750
var explosion_active: bool = false
var exposion_radius: int = 400

func explode():
	$AnimationPlayer.play("Explosion")
	explosion_active = true

func _process(_delta):
	if explosion_active:
		var targets = get_tree().get_nodes_in_group("Container") + get_tree().get_nodes_in_group("Entity")
		for target in targets:
			var in_range = targets.global_position.distance_to(global_position) < exposion_radius
			if "hit" in target and in_range:
				target.hit()
