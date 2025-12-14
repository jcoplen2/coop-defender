extends Node

func _ready():
	var egg_goal = 20
	var chicken_count = get_tree().get_nodes_in_group("chickens").size()
	GameManager.reset_game(egg_goal, chicken_count)
