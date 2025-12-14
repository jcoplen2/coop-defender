extends CharacterBody2D

@export var speed := 100
var attacking = false

@onready var anim_sprite = $AnimatedSprite2D
@onready var attack_area = $AttackArea

func _ready():
	anim_sprite.animation_finished.connect(_on_animation_finished)
	attack_area.monitoring = false  

func _physics_process(delta):
	if attacking:
		return 

	var input = Vector2(
		Input.get_action_strength("right") - Input.get_action_strength("left"),
		Input.get_action_strength("down") - Input.get_action_strength("up")
	).normalized()
	
	if velocity.x != 0:
		$AnimatedSprite2D.flip_h = velocity.x < 0
	
	velocity = input * speed
	move_and_slide()

	if input != Vector2.ZERO:
		if !anim_sprite.is_playing() or anim_sprite.animation != "walk":
			anim_sprite.play("walk")
	else:
		if !anim_sprite.is_playing() or anim_sprite.animation != "idle":
			anim_sprite.play("idle")

func _input(event):
	if event.is_action_pressed("attack") and !attacking:
		start_attack()
		$AttackSound.play()

func start_attack():
	attacking = true
	anim_sprite.play("attack")
	attack_area.monitoring = true 

func _on_animation_finished():
	if anim_sprite.animation == "attack":
		attacking = false
		attack_area.monitoring = false


func _on_attack_area_area_entered(area: Area2D) -> void:
	if area.is_in_group("snakes"):
		area.queue_free() 
