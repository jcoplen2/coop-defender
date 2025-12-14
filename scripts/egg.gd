extends Area2D

func _ready():
	connect("body_entered", _on_body_entered)

func _on_body_entered(body):
	if body.name == "Player":
		GameManager.add_egg()
		$PickupSound.play()
		await get_tree().create_timer(0.2).timeout
		queue_free()
