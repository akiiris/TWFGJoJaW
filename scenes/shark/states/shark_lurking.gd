extends Node

@onready var shark: CharacterBody2D = get_parent().get_parent()
@onready var fsm: StateMachine = get_parent()

var move_timer_min: float = 0.1
var move_timer_max: float = 1.5

func enter():
	$MoveTimer.one_shot = true
	$MoveTimer.wait_time = calc_move_timer_wait_time()
	$MoveTimer.start()


func exit(next_state: String):
	fsm.change_to(next_state)


func _process(_delta: float) -> void:
	shark.handle_direction()


func calc_move_timer_wait_time():
	var wait_time: float = randf_range(move_timer_min, move_timer_max)
	
	return wait_time


func _on_move_timer_timeout() -> void:
	if await shark.lurk():
		exit("Charging")
		return
	$MoveTimer.wait_time = calc_move_timer_wait_time()
	$MoveTimer.start()
