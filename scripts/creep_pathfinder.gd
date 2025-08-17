extends Node2D

class_name CreepPathfinder

@export var speed: float = 80.0
@export var waypoints: Array[Vector2] = []
var _current_index: int = 0

func _process(delta: float) -> void:
	if _current_index >= waypoints.size():
	queue_free()
	return
	var target: Vector2 = waypoints[_current_index]
	var to_target := target - global_position
	var step := speed * delta
	if to_target.length() <= step:
	global_position = target
	_current_index += 1
	else:
	global_position += to_target.normalized() * step
