extends CharacterBody2D

var strength: float = 1300.0
var player_velocity_multiplier: float = 0.3 # how much of an effect the player's velocity has on the hook's initial velocity
var gravity: float = 25.0
var reel_speed: float = 2000.0
var launch_strength: float = 5.0

@onready var game = get_tree().root.get_node("Main/Game")
@onready var hooks_node = game.get_node("Hooks")
@onready var fsm = $StateMachine
var rod
var rod_tip
var player

var collision_info: KinematicCollision2D


func init(rod_node, player_node) -> void:
	rod = rod_node
	player = player_node


func _ready() -> void:
	fsm.change_to("Casting")


func _process(_delta: float) -> void:
	$StateLabel.text = $StateMachine.current_state.name


func set_hook_position() -> void:
	rod_tip = rod.get_node("TipMarker")
	global_position = rod_tip.global_position


func set_initial_velocity() -> void:
	var direction = Vector2.RIGHT.rotated(rod.rotation)
	velocity = strength * direction
	velocity += player.velocity * player_velocity_multiplier


func add_gravity() -> void:
	velocity.y += gravity


func update_line_points() -> void:
	$Line.set_point_position(1, rod_tip.global_position - position)


#func _on_body_entered(body: Node) -> void:
	#attach(body)


#func attach(body: Node) -> void:
	#if body.is_in_group("map"):
		#attached_body = "map"


func reel_empty(delta: float) -> bool:
	global_position = global_position.move_toward(
		rod_tip.global_position,
		reel_speed * delta
	)
	if global_position.distance_to(rod_tip.global_position) < 1.0:
		return true
	return false


func calculate_map_launch_vector() -> Vector2:
	var hook_pos = global_position
	var player_pos = player.global_position
	var launch_vector: Vector2 = hook_pos - player_pos
	return launch_vector * launch_strength


func get_player():
	return player
