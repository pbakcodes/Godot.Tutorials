extends CanvasLayer

#colors
var green: Color = Color("6bbfa3")
var red: Color = Color(0.9, 0, 0, 1)

@onready var laser_label: Label = $LaserCounter/VBoxContainer/Label
@onready var granade_label: Label = $GranadeCounter/VBoxContainer/Label

@onready var laser_icon: TextureRect = $LaserCounter/VBoxContainer/TextureRect
@onready var granade_icon: TextureRect = $GranadeCounter/VBoxContainer/TextureRect

func _ready() -> void:
	update_color(Globals.laser_amount, laser_label, laser_icon)
	update_color(Globals.granade_amount, granade_label, granade_icon)

func update_laser_text():
	laser_label.text = str(Globals.laser_amount)
	update_color(Globals.laser_amount, laser_label, laser_icon)
	
func update_granade_text():
	granade_label.text = str(Globals.granade_amount)
	update_color(Globals.granade_amount, granade_label, granade_icon)

func update_color(amount: int, label: Label, icon: TextureRect) -> void:
	if amount <= 1:
		label.modulate = red
		icon.modulate = red
	else:
		label.modulate = green
		icon.modulate = green
