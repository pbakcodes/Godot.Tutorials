extends StaticBody2D

class_name ItemContainer

signal open(pos: Vector2, direction: Vector2)
var opened: bool = false

@onready var current_direction: Vector2 = Vector2.DOWN.rotated(rotation)
