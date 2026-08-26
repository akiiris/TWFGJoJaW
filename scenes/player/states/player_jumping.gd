extends Node

@onready var player: CharacterBody2D = get_parent().get_parent()
@onready var fsm: StateMachine = get_parent()

@onready var gravity: float = player.gravity
@onready var jump_strength: float = player.jump_strength

func enter():
	player.velocity.y = -jump_strength


func exit(next_state: String):
	fsm.change_to(next_state)


func _unhandled_key_input(event):
	player.handle_direction(event)


func _physics_process(_delta: float) -> void:
	if player.velocity.y > 0:
		exit("Falling")
	player.velocity.y += gravity
	if player.is_inputting_direction():
		player.walk()
	player.add_friction()
