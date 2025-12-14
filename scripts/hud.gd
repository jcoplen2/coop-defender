extends CanvasLayer

@onready var egg_label = $EggLabel
@onready var chicken_label = $ChickenLabel

func _ready():
	GameManager.hud = self

func update_eggs(count: int):
	egg_label.text = "Eggs: %d" % count

func update_chickens(count: int):
	chicken_label.text = "Chickens: %d" % count
