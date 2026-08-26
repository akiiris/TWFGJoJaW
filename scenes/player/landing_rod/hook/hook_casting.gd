extends Node

@onready var hook: CharacterBody2D = get_parent().get_parent()
@onready var fsm: StateMachine = get_parent()

func enter():
	hook.set_hook_position()
	hook.set_initial_velocity()


func exit():
	fsm.change_to("Attached")


func _process(_delta: float) -> void:
	hook.update_line_points()


func _physics_process(delta: float) -> void:
	hook.add_gravity()
	var collision_info = hook.move_and_collide(hook.velocity * delta)
	if collision_info:
		exit()
