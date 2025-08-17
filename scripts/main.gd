extends Node2D

@onready var path: Path2D = $Path2D
@onready var spawn_timer: Timer = $SpawnTimer
@onready var creep_scene: PackedScene = preload("res://scenes/creep.tscn")
@onready var tower_scene: PackedScene = preload("res://scenes/tower.tscn")
@onready var gold_label: Label = $UI/GoldLabel
@onready var wave_label: Label = $UI/WaveLabel
@onready var tile_map: TileMap = $TileMap

const GRID_SIZE: int = 64
var occupied_cells := {}
var player_gold: int = 100

var waves := [
		{ "count": 5, "health_multiplier": 1.0, "interval": 1.0 },
		{ "count": 8, "health_multiplier": 1.2, "interval": 0.8 }
]

var current_wave: int = 0
var creeps_spawned: int = 0

func _ready() -> void:
	if path.curve == null:
		path.curve = Curve2D.new()
	path.curve.clear_points()
	path.curve.add_point(Vector2(0, 300))
	path.curve.add_point(Vector2(600, 300))
	spawn_timer.timeout.connect(_on_spawn_timer_timeout)
	for x in range(40):
		for y in range(25):
			tile_map.set_cell(0, Vector2i(x, y), 0, Vector2i.ZERO)
	start_wave()
	_update_gold_label()


func start_wave() -> void:
		if current_wave >= waves.size():
				return
		creeps_spawned = 0
		var wave = waves[current_wave]
		spawn_timer.wait_time = wave.interval
		if wave_label:
				wave_label.text = "Wave %d" % (current_wave + 1)
		spawn_timer.start()

func _on_spawn_timer_timeout() -> void:
		var wave = waves[current_wave]
		var creep := creep_scene.instantiate()
		creep.path = path
		creep.health = int(creep.health * wave.health_multiplier)
		add_child(creep)
		creeps_spawned += 1
		if creeps_spawned >= wave.count:
				spawn_timer.stop()
				current_wave += 1
				if current_wave < waves.size():
						await get_tree().create_timer(2.0).timeout
						start_wave()


func _unhandled_input(event: InputEvent) -> void:
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT and event.pressed:
		var cell := _world_to_cell(event.position)
		if not _is_cell_free(cell):
			return
		if _is_on_path(event.position):
			return
		var tower := tower_scene.instantiate()
		if spend_gold(tower.cost):
			tower.global_position = _cell_to_world(cell)
			add_child(tower)
			occupied_cells[cell] = true

func _world_to_cell(pos: Vector2) -> Vector2i:
	return Vector2i(floor(pos.x / GRID_SIZE), floor(pos.y / GRID_SIZE))

func _cell_to_world(cell: Vector2i) -> Vector2:
	return Vector2(cell.x * GRID_SIZE + GRID_SIZE / 2, cell.y * GRID_SIZE + GRID_SIZE / 2)

func _is_cell_free(cell: Vector2i) -> bool:
	return not occupied_cells.has(cell)

func _is_on_path(pos: Vector2) -> bool:
	if path and path.curve:
		var closest = path.curve.get_closest_point(pos)
		return pos.distance_to(closest) < GRID_SIZE / 2
	return false

func _update_gold_label() -> void:
		gold_label.text = "Gold: %d" % player_gold

func add_gold(amount: int) -> void:
		player_gold += amount
		_update_gold_label()

func spend_gold(amount: int) -> bool:
		if player_gold >= amount:
				player_gold -= amount
				_update_gold_label()
				return true
		return false
