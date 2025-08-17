extends Node2D

@export var speed: float = 50.0
@export var health: int = 10
var path: Path2D
var distance: float = 0.0


func _enter_tree() -> void:
	add_to_group("creeps")


func _exit_tree() -> void:
	remove_from_group("creeps")


func _ready() -> void:
	queue_redraw()


func take_damage(amount: int) -> void:
	health -= amount
	if health <= 0:
		queue_free()


func _process(delta: float) -> void:
	if path == null:
		return
	distance += speed * delta
	var curve := path.curve
	var length := curve.get_baked_length()
	global_position = path.to_global(curve.sample_baked(distance))
	if distance >= length:
		queue_free()


func _draw() -> void:
	draw_circle(Vector2.ZERO, 8.0, Color.RED)
