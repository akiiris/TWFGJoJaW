extends Node

@onready var player: CharacterBody2D = get_parent().get_parent()
@onready var fsm: StateMachine = get_parent()

func enter():
	pass


func exit(next_state: String):
	fsm.change_to(next_state)


func _unhandled_key_input(event: InputEvent):
	if event.is_action_pressed("move_left") or event.is_action_pressed("move_right"):
		exit("Walking")
		return
	if event.is_action_pressed("jump"):
		exit("Jumping")
		return


func _physics_process(_delta: float) -> void:
	if not player.is_on_floor():
		exit("Falling")
		return
	player.add_friction()
