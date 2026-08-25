extends CharacterBody2D

var gravity: float = 40.0
var walk_speed: float = 300.0
var friction: float = 60.0
var jump_strength: float = 1400.0

func _process(delta: float) -> void:
	$Label.text = $StateMachine.current_state.name


func _physics_process(delta: float) -> void:
	move_and_slide()
