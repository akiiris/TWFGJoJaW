extends Node

@onready var player: CharacterBody2D = get_parent().get_parent()
@onready var fsm: StateMachine = get_parent()
@onready var gravity: float = player.gravity

func enter():
	pass


func exit():
	pass


func _physics_process(delta: float) -> void:
	player.velocity.y += gravity
	player.move_and_slide()
