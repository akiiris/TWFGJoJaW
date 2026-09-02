extends Node

@onready var hook: CharacterBody2D = get_parent().get_parent()
@onready var fsm: StateMachine = get_parent()

var object_is_enemy: bool

func enter() -> void:
	if hook.hooked is CharacterBody2D:
		hook.reparent.call_deferred(hook.hooked)
		object_is_enemy = true
	else:
		object_is_enemy = false


func exit(next_state: String) -> void:
	fsm.change_to(next_state)


func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("cast"):
		if object_is_enemy:
			exit("ReelingEnemy")
		else:
			exit("ReelingMap")


func _process(_delta: float) -> void:
	hook.update_line_points()
