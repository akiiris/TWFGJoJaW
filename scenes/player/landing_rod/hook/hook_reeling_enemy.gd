extends Node

@onready var hook: CharacterBody2D = get_parent().get_parent()
@onready var fsm: StateMachine = get_parent()

func enter():
	pass


func exit():
	queue_free()


func _process(_delta: float) -> void:
	hook.update_line_points()


func _physics_process(delta: float) -> void:
	if hook.reel_empty(delta):
		exit()
