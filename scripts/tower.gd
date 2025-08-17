extends Node2D

@export var attack_range: float = 120.0
@export var fire_rate: float = 1.0
@export var damage: int = 5
@export var cost: int = 10
var cooldown: float = 0.0
const PROJECTILE_SCENE := preload("res://scenes/projectile.tscn")


func _ready() -> void:
	queue_redraw()


func _process(delta: float) -> void:
	cooldown -= delta
	if cooldown <= 0.0:
		var target = _get_target()
		if target:
			var projectile := PROJECTILE_SCENE.instantiate()
			projectile.global_position = global_position
			projectile.target = target
			projectile.damage = damage
			get_tree().current_scene.add_child(projectile)
			cooldown = 1.0 / fire_rate

func _get_target() -> Node2D:
	var closest: Node2D = null
	var closest_dist := attack_range
	for creep: Node2D in get_tree().get_nodes_in_group("creeps"):
		var dist := global_position.distance_to(creep.global_position)
		if dist < closest_dist:
			closest = creep
			closest_dist = dist
	return closest

func _draw() -> void:
	draw_circle(Vector2.ZERO, 12.0, Color.BLUE)
