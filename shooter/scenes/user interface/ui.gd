extends CanvasLayer

@onready var laser_label: Label = $LaserCounter/VBoxContainer/Label
@onready var grenade_label: Label = $GrenadeCounter/VBoxContainer/Label
@onready var laser_icon: TextureRect = $LaserCounter/VBoxContainer/TextureRect
@onready var grenade_icon: TextureRect = $GrenadeCounter/VBoxContainer/TextureRect
@onready var health_bar: TextureProgressBar = $MarginContainer/TextureProgressBar

func _ready() -> void:
	Globals.stat_change.connect(_on_stat_change)
	_update_laser_display()
	_update_grenade_display()
	_update_health_display()

func _update_laser_display() -> void:
	laser_label.text = str(Globals.laser_amount)
	_update_color(Globals.laser_amount, laser_label, laser_icon)

func _update_grenade_display() -> void:
	grenade_label.text = str(Globals.grenade_amount)
	_update_color(Globals.grenade_amount, grenade_label, grenade_icon)

func _update_health_display() -> void:
	health_bar.value = Globals.health

func _on_stat_change() -> void:
	_update_laser_display()
	_update_grenade_display()
	_update_health_display()

func _update_color(amount: int, label: Label, icon: TextureRect) -> void:
	if amount <= 1:
		label.modulate = Constants.COLOR_UI_RED
		icon.modulate = Constants.COLOR_UI_RED
	else:
		label.modulate = Constants.COLOR_UI_GREEN
		icon.modulate = Constants.COLOR_UI_GREEN
