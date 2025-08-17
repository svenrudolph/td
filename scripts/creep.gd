extends Node2D

@export var speed: float = 50.0
@export var max_health: int = 10
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
	queue_redraw()
	if health <= 0:
		get_node("/root/Main").add_gold(5)
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
	var bar_width := 16.0
	var bar_height := 4.0
	var bar_offset := Vector2(-bar_width / 2, -12.0)
	var ratio := float(health) / float(max_health)
	draw_rect(Rect2(bar_offset, Vector2(bar_width, bar_height)), Color.RED)
	draw_rect(Rect2(bar_offset, Vector2(bar_width * ratio, bar_height)), Color.GREEN)
