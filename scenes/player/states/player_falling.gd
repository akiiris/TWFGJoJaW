extends Node

@onready var player: CharacterBody2D = get_parent().get_parent()
@onready var fsm: StateMachine = get_parent()

@onready var gravity: float = player.gravity

func enter():
	pass


func exit(next_state: String):
	fsm.change_to(next_state)


func _unhandled_key_input(event):
	player.handle_direction(event)


func _physics_process(_delta: float) -> void:
	if player.is_on_floor():
		var next_state: String = "Idle"
		if Input.is_action_pressed("move_left") or Input.is_action_pressed("move_right"):
			next_state = "Walking"
		exit(next_state)
	player.velocity.y += gravity
	if player.is_inputting_direction():
		player.walk()
	player.add_friction()
