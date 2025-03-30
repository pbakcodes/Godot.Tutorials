extends ItemContainer

func hit() -> void:
	if not opened:
		$LidSprite.hide()
		var pos: Vector2 = $SpawnPositions/Marker2D.global_position
		open.emit(pos, current_direction)
		opened = true
