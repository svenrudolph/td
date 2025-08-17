extends Node2D

@onready var path: Path2D = $Path2D
@onready var wave_spawner: Node2D = $WaveSpawner
@onready var creep_scene: PackedScene = preload("res://scenes/creep.tscn")
@onready var tower_scene: PackedScene = preload("res://scenes/tower.tscn")
@onready var gold_label: Label = $UI/GoldLabel
@onready var wave_label: Label = $UI/WaveLabel
@onready var tile_map: TileMap = $TileMap
@onready var build_button: Button = $UI/BuildButton

const GRID_SIZE: int = 64
var occupied_cells := {}
var player_gold: int = 100
var selected_tower_scene: PackedScene = null

var waves := [
	{ "count": 5, "health_multiplier": 1.0, "interval": 1.0 },
	{ "count": 8, "health_multiplier": 1.2, "interval": 0.8 }
]

func _ready() -> void:
	if path.curve == null:
		path.curve = Curve2D.new()
	path.curve.clear_points()
	path.curve.add_point(Vector2(0, 300))
	path.curve.add_point(Vector2(600, 300))
	for x in range(40):
		for y in range(25):
			tile_map.set_cell(0, Vector2i(x, y), 0, Vector2i.ZERO)
	wave_spawner.creep_scene = creep_scene
	wave_spawner.waves = waves
	wave_spawner.waypoints = _get_waypoints()
	wave_spawner.wave_started.connect(_on_wave_started)
	_update_gold_label()
	var temp_tower: Node = tower_scene.instantiate()
	build_button.text = "Build Tower (%d)" % temp_tower.cost
	build_button.toggled.connect(_on_build_button_toggled)
	temp_tower.queue_free()
	_on_wave_started(0)

func _unhandled_input(event: InputEvent) -> void:
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT and event.pressed:
		if selected_tower_scene == null:
			return
		var cell := _world_to_cell(event.position)
		if not _is_cell_free(cell):
			return
		if _is_on_path(event.position):
			return
		var tower := selected_tower_scene.instantiate()
		if spend_gold(tower.cost):
			tower.global_position = _cell_to_world(cell)
			add_child(tower)
			occupied_cells[cell] = true
			build_button.button_pressed = false
			selected_tower_scene = null

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

func _get_waypoints() -> Array[Vector2]:
	var pts: Array[Vector2] = []
	var curve := path.curve
	for i in range(curve.get_point_count()):
		pts.append(path.to_global(curve.get_point_position(i)))
	return pts

func _on_wave_started(index: int) -> void:
	if wave_label:
		wave_label.text = "Wave %d" % (index + 1)

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

func _on_build_button_toggled(pressed: bool) -> void:
	if pressed:
		selected_tower_scene = tower_scene
	else:
		selected_tower_scene = null
