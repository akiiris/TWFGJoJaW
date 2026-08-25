extends CharacterBody2D

var gravity: float = 40.0

func _process(delta: float) -> void:
	$Label.text = $StateMachine.current_state.name
