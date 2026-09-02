extends Node

@onready var shark: CharacterBody2D = get_parent().get_parent()
@onready var fsm: StateMachine = get_parent()

func enter():
	await shark.set_bite(true)
	shark.set_bite(false)
	exit("Retreating")


func exit(next_state: String):
	fsm.change_to(next_state)
