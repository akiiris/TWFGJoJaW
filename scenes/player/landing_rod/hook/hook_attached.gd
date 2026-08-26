extends Node

@onready var hook: CharacterBody2D = get_parent().get_parent()
@onready var fsm: StateMachine = get_parent()

func enter() -> void:
	pass


func exit(next_state: String) -> void:
	fsm.change_to(next_state)


func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("cast"):
		exit("ReelingMap")


func _process(_delta: float) -> void:
	hook.update_line_points()
