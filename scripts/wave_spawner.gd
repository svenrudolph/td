extends Node2D

@export var creep_scene: PackedScene
@export var waves: Array[Dictionary] = [ { "count": 5, "interval": 1.0 } ]
var _current_wave: int = 0
var _spawned_in_wave: int = 0
var _timer: float = 0.0

func _process(delta: float) -> void:
	if _current_wave >= waves.size():
		return
	_timer -= delta
	if _timer <= 0.0:
		_spawn_creep()
		var wave = waves[_current_wave]
		_spawned_in_wave += 1
		if _spawned_in_wave >= wave.count:
			_current_wave += 1
			_spawned_in_wave = 0
			_timer = 2.0
		else:
			_timer = wave.interval

func _spawn_creep() -> void:
	if creep_scene == null:
		return
	var creep = creep_scene.instantiate()
	creep.global_position = global_position
	get_parent().add_child(creep)
