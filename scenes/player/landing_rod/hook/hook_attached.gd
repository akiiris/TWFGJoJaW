extends Node

@onready var hook: CharacterBody2D = get_parent().get_parent()
@onready var fsm: StateMachine = get_parent()

func enter() -> void:
	pass


func exit() -> void:
	fsm.change_to("Reeling")


func _process(delta: float) -> void:
	hook.update_line_points()
