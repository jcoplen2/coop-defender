extends Node

var eggs_collected: int = 0
var chickens_alive: int = 0
var eggs_required: int = 20

var hud: CanvasLayer

func reset_game(egg_goal: int, chicken_count: int):
	eggs_required = egg_goal
	eggs_collected = 0
	chickens_alive = chicken_count

	if hud:
		hud.update_eggs(eggs_collected)
		hud.update_chickens(chickens_alive)

func add_egg():
	eggs_collected += 1
	if hud:
		hud.update_eggs(eggs_collected)
	check_win_condition()

func chicken_lost():
	chickens_alive -= 1
	if hud:
		hud.update_chickens(chickens_alive)
	check_loss_condition()

func check_win_condition():
	if eggs_collected >= eggs_required:
		get_tree().change_scene_to_file("res://scenes/win.tscn")

func check_loss_condition():
	if chickens_alive <= 0 and eggs_collected < eggs_required:
		get_tree().change_scene_to_file("res://scenes/lose.tscn")
