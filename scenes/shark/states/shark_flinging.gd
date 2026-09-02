extends Node

@onready var shark: CharacterBody2D = get_parent().get_parent()
@onready var fsm: StateMachine = get_parent()

func enter():
	pass


func exit(next_state: String):
	fsm.change_to(next_state)
