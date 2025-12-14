extends Area2D

@export var wander_speed: float = 20
var direction = Vector2.ZERO

@onready var anim_sprite: AnimatedSprite2D = $AnimatedSprite2D
@onready var wander_timer = Timer.new()
@onready var egg_timer = Timer.new()
var egg_scene = preload("res://scenes/egg.tscn")  # Update path as needed

func _ready():
	add_to_group("chickens")

	# Setup wander timer
	wander_timer.wait_time = 2.0
	wander_timer.autostart = true
	wander_timer.one_shot = false
	wander_timer.timeout.connect(_on_wander_timeout)
	add_child(wander_timer)

	# Setup egg timer with random start
	egg_timer.wait_time = randf_range(5.0, 15.0)
	egg_timer.autostart = true
	egg_timer.one_shot = false
	egg_timer.timeout.connect(_on_egg_timer_timeout)
	add_child(egg_timer)

	anim_sprite.play("idle")

func _physics_process(delta):
	position += direction * wander_speed * delta

func _on_wander_timeout():
	direction = Vector2(randf_range(-1.0, 1.0), randf_range(-1.0, 1.0)).normalized()
	anim_sprite.play("idle")  # Idle anim plays even when wandering

func _on_egg_timer_timeout() -> void:
	var egg = egg_scene.instantiate()
	egg.global_position = global_position
	get_tree().current_scene.add_child(egg)
	
	# Reset egg timer to new random time
	egg_timer.wait_time = randf_range(5.0, 15.0)
	egg_timer.start()
