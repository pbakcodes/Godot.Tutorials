extends ItemContainer

func hit(_damage: int = 0) -> void:
	if not opened:
		$LidSprite.hide()
		for i in range(5):
			var pos: Vector2 = $SpawnPositions.get_children().pick_random().global_position
			open.emit(pos, current_direction)
		opened = true
