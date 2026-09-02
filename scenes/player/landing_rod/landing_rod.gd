extends Node2D

var hook_scene: PackedScene = preload("res://scenes/player/landing_rod/hook/hook.tscn")

@onready var game = get_tree().root.get_node("Main/Game")
@onready var player = get_parent().get_parent()
@onready var hooks_node = game.get_node("Hooks")

var hook: CharacterBody2D = null

func _physics_process(_delta: float) -> void:
	look_at(get_global_mouse_position())


func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("cast"):
		if not hook_exists():
			cast()


func hook_exists() -> bool:
	if hook:
		return true
	return false


func cast() -> void:
	hook = hook_scene.instantiate()
	hook.init(self, player)
	hooks_node.add_child(hook)
