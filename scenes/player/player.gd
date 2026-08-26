extends CharacterBody2D

var gravity: float = 30.0
var walk_speed: float = 400.0
var friction: float = 60.0
var jump_strength: float = 1100.0

var direction: int = 1

func _process(_delta: float) -> void:
	$Label.text = $StateMachine.current_state.name


func _physics_process(_delta: float) -> void:
	move_and_slide()


func walk() -> void:
	velocity.x = walk_speed * direction


func add_friction() -> void:
	velocity.x -= friction * sign(velocity.x)
	if abs(velocity.x) <= friction:
		velocity.x = 0


func is_inputting_direction() -> bool:
	if Input.is_action_pressed("move_left") or Input.is_action_pressed("move_right"):
		return true
	return false


func handle_direction(event) -> void:
	if event.is_action_pressed("move_left"):
		direction = -1
	if event.is_action_pressed("move_right"):
		direction = 1
