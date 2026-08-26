extends Node

@onready var hook: CharacterBody2D = get_parent().get_parent()
@onready var fsm: StateMachine = get_parent()

func enter():
	pass


func exit():
	pass


func _process(_delta: float) -> void:
	hook.update_line_points()
