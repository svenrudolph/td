extends Node2D

@export var attack_range: float = 120.0
@export var fire_rate: float = 1.0
@export var damage: int = 5
@export var cost: int = 10
var cooldown: float = 0.0


func _ready() -> void:
	queue_redraw()


func _process(delta: float) -> void:
	cooldown -= delta
	if cooldown <= 0.0:
		var target = _get_target()
		if target:
			target.take_damage(damage)
			cooldown = 1.0 / fire_rate

func _get_target() -> Node2D:
	var closest: Node2D = null
	var closest_dist := attack_range
	for creep in get_tree().get_nodes_in_group("creeps"):
		var dist := global_position.distance_to(creep.global_position)
		if dist < closest_dist:
			closest = creep
			closest_dist = dist
	return closest

func _draw() -> void:
	draw_circle(Vector2.ZERO, 12.0, Color.BLUE)
