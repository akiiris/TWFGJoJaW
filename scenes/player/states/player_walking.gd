extends Node

@onready var player: CharacterBody2D = get_parent().get_parent()
@onready var fsm: StateMachine = get_parent()

var speed: float = 300.0

var direction: int

func enter():
	if Input.is_action_pressed("move_left"):
		direction = -1
	else:
		direction = 1


func exit(next_state):
	fsm.change_to(next_state)


func _unhandled_key_input(event):
	if event.is_action_pressed("move_left"):
		direction = -1
	if event.is_action_pressed("move_right"):
		direction = 1


func _process(delta: float) -> void:
	if not Input.is_action_pressed("move_left") and not Input.is_action_pressed("move_right"):
		exit("Idle")


func _physics_process(delta: float) -> void:
	if not player.is_on_floor():
		exit("Falling")
	walk()
	player.move_and_slide()


func walk() -> void:
	player.velocity.x = speed * direction
