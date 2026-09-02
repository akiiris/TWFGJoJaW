extends Node

@onready var shark: CharacterBody2D = get_parent().get_parent()
@onready var fsm: StateMachine = get_parent()

func enter():
	shark.rotation_reset()
	if shark.check_distance_for_retreat():
		exit("Lurking")
		return


func exit(next_state: String):
	fsm.change_to(next_state)


func _physics_process(_delta: float) -> void:
	if shark.retreat():
		exit("Lurking")
