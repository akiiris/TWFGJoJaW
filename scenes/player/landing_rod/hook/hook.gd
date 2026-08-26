extends RigidBody2D

var strength: float = 1000.0
var player_velocity_multiplier: float = 0.3 # how much of an effect the player's velocity has on the hook's initial velocity

var rod
var rod_tip
var player

func init(rod_node, player_node) -> void:
	rod = rod_node
	player = player_node


func _ready() -> void:
	rod_tip = rod.get_node("TipMarker")
	set_hook_position()
	set_initial_velocity()


func _process(delta: float) -> void:
	update_line_points()


func set_hook_position() -> void:
	global_position = rod_tip.global_position


func set_initial_velocity() -> void:
	var direction = Vector2.RIGHT.rotated(rod.rotation)
	linear_velocity = strength * direction
	linear_velocity += player.velocity * player_velocity_multiplier


func update_line_points() -> void:
	$Line.set_point_position(1, rod_tip.global_position - position)
