extends Node2D

signal wave_started(index: int)

@export var creep_scene: PackedScene
@export var waves: Array[Dictionary] = [ { "count": 5, "interval": 1.0 } ]
@export var waypoints: Array[Vector2] = []
var _current_wave: int = 0
var _spawned_in_wave: int = 0
var _timer: float = 0.0

func _process(delta: float) -> void:
	if _current_wave >= waves.size():
		return
	_timer -= delta
	if _timer <= 0.0:
		var wave = waves[_current_wave]
		if _spawned_in_wave == 0:
			wave_started.emit(_current_wave)
		_spawn_creep(wave)
		_spawned_in_wave += 1
		if _spawned_in_wave >= wave.count:
			_current_wave += 1
			_spawned_in_wave = 0
			_timer = 2.0
		else:
			_timer = wave.interval

func _spawn_creep(wave: Dictionary) -> void:
	if creep_scene == null:
		return
	var creep = creep_scene.instantiate()
	creep.global_position = global_position
	if waypoints.size() > 0:
		creep.waypoints = waypoints.duplicate()
	if wave.has("health_multiplier"):
		creep.health = int(creep.health * wave.health_multiplier)
	get_parent().add_child(creep)
