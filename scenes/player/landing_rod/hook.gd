extends RigidBody2D

var strength: float = 1000.0

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


func set_hook_position() -> void:
	global_position = rod_tip.global_position


func set_initial_velocity() -> void:
	var direction = Vector2.RIGHT.rotated(rod.rotation)
	linear_velocity = strength * direction
