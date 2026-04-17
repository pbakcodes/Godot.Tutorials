extends RigidBody2D

func explode() -> void:
	$AnimationPlayer.play("Explosion")
	_apply_explosion_damage()

func _apply_explosion_damage() -> void:
	var targets: Array[Node] = []
	targets.append_array(get_tree().get_nodes_in_group("Container"))
	targets.append_array(get_tree().get_nodes_in_group("Entity"))
	var player_pos: Vector2 = Globals.player_position
	var player_in_range: bool = player_pos.distance_to(global_position) < Constants.GRENADE_EXPLOSION_RADIUS
	if player_in_range:
		Globals.health -= Constants.GRENADE_DAMAGE
	for target in targets:
		var in_range: bool = target.global_position.distance_to(global_position) < Constants.GRENADE_EXPLOSION_RADIUS
		if target.has_method("hit") and in_range:
			target.hit(Constants.GRENADE_DAMAGE)
