extends Area2D

@export var speed := 40
var target: Area2D

@onready var anim_sprite = $AnimatedSprite2D

func _ready():
	anim_sprite.play("slither")
	find_nearest_chicken()

func _physics_process(delta):
	if target and is_instance_valid(target):
		var direction = (target.global_position - global_position).normalized()
		global_position += direction * speed * delta
		anim_sprite.flip_h = direction.x < 0
	else:
		find_nearest_chicken()

func find_nearest_chicken():
	var chickens = get_tree().get_nodes_in_group("chickens")
	var closest_dist = INF
	var closest = null

	for chicken in chickens:
		if is_instance_valid(chicken):
			var dist = global_position.distance_to(chicken.global_position)
			if dist < closest_dist:
				closest_dist = dist
				closest = chicken
	
	target = closest  # ← Don't forget this line!


func _on_area_entered(area: Area2D) -> void:
	if area.is_in_group("chickens"):
		GameManager.chicken_lost()
		$DeathSound.play()
		area.queue_free()  # remove chicken
