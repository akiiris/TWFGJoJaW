extends CharacterBody2D

@onready var game: Node2D = get_tree().root.get_node("Main/Game")
@onready var sharks_node: Node = game.get_node("Sharks")
@onready var player: CharacterBody2D = game.get_node("Player")
@onready var mouth_marker: Marker2D = get_node("MouthMarker")
@onready var bite_area: Area2D = mouth_marker.get_node("BiteArea")
@onready var fsm: StateMachine = $StateMachine

var lurk_distance: float = 400.0
var charge_speed: float = 1600.0
var retreat_speed: float = 800.0

func _ready() -> void:
	fsm.change_to("Lurking")


func _process(_delta: float) -> void:
	$StateLabel.text = $StateMachine.current_state.name


func lurk() -> bool:
	var move_time: float = 0.8
	
	var direction := (global_position - player.global_position).normalized()
	var target_position := player.global_position + direction * lurk_distance
	
	var tween: Tween = get_tree().create_tween()
	tween.tween_property(self, "global_position", target_position, move_time).set_trans(Tween.TRANS_SINE)
	
	await get_tree().create_timer(move_time).timeout
	return randi_range(1, 4) == 1 # 25% chance


func handle_direction() -> void:
	var dir = sign(player.global_position.x - global_position.x)
	if dir != 0:
		scale.x = dir


func charge(target_position: Vector2) -> bool:
	var dir = global_position.direction_to(target_position)
	velocity = dir * charge_speed
	
	move_and_slide()
	
	return global_position.distance_to(target_position) <= mouth_marker.position.x


func rotate_toward_player() -> void:
	var rotation_time: float = 0.2
	
	var direction_to_player: float = global_position.direction_to(player.global_position).angle()
	var tween: Tween = get_tree().create_tween()
	tween.tween_property(self, "rotation", direction_to_player, rotation_time)


func rotation_reset() -> void:
	var rotation_time: float = 0.2
	
	var tween: Tween = get_tree().create_tween()
	tween.tween_property(self, "rotation", 0.0, rotation_time)


func set_bite(val: bool) -> void:
	var bite_time: float = 0.4
	var bite_area_col: CollisionShape2D = bite_area.get_node("Col")
	var bite_area_spr: ColorRect = bite_area.get_node("Spr")
	if val:
		bite_area_col.set_deferred("disabled", true)
		bite_area_spr.visible = true
		await get_tree().create_timer(bite_time).timeout
	else:
		bite_area_col.set_deferred("disabled", false)
		bite_area_spr.visible = false


func check_distance_for_retreat() -> bool:
	return global_position.distance_to(player.global_position) > lurk_distance


func retreat() -> bool:
	var dir = player.global_position.direction_to(global_position)
	velocity = dir * retreat_speed
	
	move_and_slide()
	
	return check_distance_for_retreat()
