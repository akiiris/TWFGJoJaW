extends Node

@onready var hook: CharacterBody2D = get_parent().get_parent()
@onready var fsm: StateMachine = get_parent()

func enter():
	hook.set_hook_position()
	hook.set_initial_velocity()


func exit(next_state: String, collision_info: KinematicCollision2D = null):
	hook.collision_info = collision_info
	fsm.change_to(next_state)


func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("cast"):
		exit("ReelingEmpty")


func _process(_delta: float) -> void:
	hook.update_line_points()


func _physics_process(delta: float) -> void:
	hook.add_gravity()
	var collision_info: KinematicCollision2D = hook.move_and_collide(hook.velocity * delta)
	if collision_info:
		exit("Attached", collision_info)
