extends Node2D

var hook_scene: PackedScene = preload("res://scenes/player/landing_rod/hook/hook.tscn")

@onready var game = get_tree().root.get_node("Main/Game")
@onready var player = get_parent().get_parent()

var hook

func _physics_process(delta: float) -> void:
	look_at(get_global_mouse_position())


func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("cast"):
		cast()


func cast() -> void:
	hook = hook_scene.instantiate()
	hook.init(self, player)
	game.add_child(hook)
