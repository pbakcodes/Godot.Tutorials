extends Area2D

enum ItemType { LASER, GRENADE, HEALTH }

var rotation_speed: int = 2
var type: ItemType
var direction: Vector2
var distance: int = randi_range(150, 250)

func _process(delta: float) -> void:
	rotation += rotation_speed * delta

func _pick_weighted_random_type() -> ItemType:
	# Reroll up to 3 times to bias toward LASER drops
	var attempts: int = 0
	while attempts < 3:
		var result: ItemType = ItemType.values().pick_random()
		if result == ItemType.LASER:
			return result
		attempts += 1
	return ItemType.values().pick_random()

func _ready() -> void:
	type = _pick_weighted_random_type()

	match type:
		ItemType.LASER:
			$Sprite2D.modulate = Constants.COLOR_ITEM_LASER
		ItemType.GRENADE:
			$Sprite2D.modulate = Constants.COLOR_ITEM_GRENADE
		ItemType.HEALTH:
			$Sprite2D.modulate = Constants.COLOR_ITEM_HEALTH

	var target_pos: Vector2 = position + direction * distance
	var tween: Tween = create_tween()
	tween.set_parallel(true)
	tween.tween_property(self, "position", target_pos, 0.5)
	tween.tween_property(self, "scale", Vector2(1, 1), 0.3).from(Vector2(0, 0))

func _on_body_entered(_body: Node2D) -> void:
	match type:
		ItemType.LASER:
			Globals.laser_amount += Constants.LASER_PICKUP_AMOUNT
		ItemType.GRENADE:
			Globals.grenade_amount += Constants.GRENADE_PICKUP_AMOUNT
		ItemType.HEALTH:
			Globals.health += Constants.HEALTH_PICKUP_AMOUNT
	queue_free()
