extends Node2D

@export var speed: float = 200.0
var target: Node2D
var damage: int = 0


func _ready() -> void:
	queue_redraw()


func _process(delta: float) -> void:
	if target == null or !is_instance_valid(target):
		queue_free()
		return
	var to_target := target.global_position - global_position
	var dist := to_target.length()
	if dist <= speed * delta or dist == 0:
		target.take_damage(damage)
		queue_free()
	else:
		global_position += to_target.normalized() * speed * delta


func _draw() -> void:
	draw_circle(Vector2.ZERO, 4.0, Color.YELLOW)
