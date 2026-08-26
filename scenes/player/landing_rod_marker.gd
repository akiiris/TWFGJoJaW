extends Marker2D

var landing_rod_scene: PackedScene = preload("res://scenes/player/landing_rod/landing_rod.tscn")

func _ready() -> void:
	var landing_rod = landing_rod_scene.instantiate()
	add_child(landing_rod)
