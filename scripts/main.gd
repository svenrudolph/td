extends Node2D

@onready var path: Path2D = $Path2D
@onready var spawn_timer: Timer = $SpawnTimer
@onready var creep_scene := preload("res://scenes/creep.tscn")
@onready var tower_scene := preload("res://scenes/tower.tscn")

func _ready() -> void:
    if path.curve == null:
        path.curve = Curve2D.new()
    path.curve.clear_points()
    path.curve.add_point(Vector2(0, 300))
    path.curve.add_point(Vector2(600, 300))
    spawn_timer.timeout.connect(_on_spawn_timer_timeout)
    spawn_timer.start()

func _on_spawn_timer_timeout() -> void:
    var creep = creep_scene.instantiate()
    creep.path = path
    add_child(creep)

func _unhandled_input(event: InputEvent) -> void:
    if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT and event.pressed:
        var tower = tower_scene.instantiate()
        tower.global_position = event.position
        add_child(tower)
