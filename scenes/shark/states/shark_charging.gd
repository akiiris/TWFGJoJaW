extends Node

@onready var shark: CharacterBody2D = get_parent().get_parent()
@onready var fsm: StateMachine = get_parent()
@onready var player: CharacterBody2D = get_tree().root.get_node("Main/Game/Player")

var target_position: Vector2

func enter():
	target_position = player.global_position
	shark.rotate_toward_player()


func exit(next_state: String):
	fsm.change_to(next_state)


func _physics_process(_delta: float) -> void:
	if shark.charge(target_position):
		exit("Biting")
