extends CharacterBody2D

@onready var game: Node2D = get_tree().root.get_node("Main/Game")
@onready var sharks_node: Node = game.get_node("Sharks")
@onready var player: CharacterBody2D = game.get_node("Player")
@onready var fsm: StateMachine = $StateMachine

var lurking_distance: float = 300.0

func _ready() -> void:
	fsm.change_to("Lurking")


func _process(_delta: float) -> void:
	$StateLabel.text = $StateMachine.current_state.name


func lurk() -> bool:
	var move_time: float = 0.8
	
	var direction := (global_position - player.global_position).normalized()
	var target_position := player.global_position + direction * lurking_distance
	
	var tween: Tween = get_tree().create_tween()
	tween.tween_property(self, "global_position", target_position, move_time).set_trans(Tween.TRANS_SINE)
	
	await get_tree().create_timer(move_time).timeout
	return randi_range(1, 6) == 1 # 1 in 6 chance


func charge(target_position: Vector2) -> void:
	var move_speed: float = 1000.0
	
	var target_velocity = global_position.direction_to(target_position) * move_speed
	velocity = target_velocity
	
	move_and_slide()


func rotate_toward_player() -> void:
	var rotation_time: float = 0.2
	
	var direction_to_player: float = global_position.direction_to(player.global_position).angle()
	var tween: Tween = get_tree().create_tween()
	tween.tween_property(self, "rotation", direction_to_player, rotation_time)
