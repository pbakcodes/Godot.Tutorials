extends Node2D


func _on_area_2d_body_entered(_body: Node2D) -> void:
	print("body has entered")


func _on_area_2d_body_exited(_body: Node2D) -> void:
	print("body has exited")
