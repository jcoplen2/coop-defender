extends Node

@export var snake_scene: PackedScene
@export var max_snakes: int = 3
@export var spawn_interval: float = 3.0

var current_snakes: int = 0

func _ready():
	spawn_snake()
	# Start spawning loop
	_spawn_timer()

func _spawn_timer():
	await get_tree().create_timer(spawn_interval).timeout
	if current_snakes < max_snakes:
		spawn_snake()
	_spawn_timer()

func spawn_snake():
	if not snake_scene:
		return

	var spawn_points = get_children().filter(func(c): return c is Marker2D)
	if spawn_points.is_empty():
		return

	var random_point = spawn_points[randi() % spawn_points.size()]
	var snake = snake_scene.instantiate()
	snake.global_position = random_point.global_position
	get_parent().add_child(snake)

	current_snakes += 1

	# When the snake is removed, decrease the count
	snake.tree_exited.connect(func(): current_snakes -= 1)
