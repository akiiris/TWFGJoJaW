extends Node

@onready var player: CharacterBody2D = get_parent().get_parent()
@onready var fsm: StateMachine = get_parent()

@onready var friction: float = player.friction

func enter():
	pass


func exit(next_state):
	fsm.change_to(next_state)


func _unhandled_key_input(event):
	if event.is_action_pressed("move_left") or event.is_action_pressed("move_right"):
		exit("Walking")
	if event.is_action_pressed("jump"):
		exit("Jumping")


func _physics_process(delta: float) -> void:
	if not player.is_on_floor():
		exit("Falling")
	add_friction()


func add_friction():
	player.velocity.x -= friction * sign(player.velocity.x)
