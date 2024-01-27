extends Node2D

func _ready():
	pass

func _on_play_button_pressed():
	GlobalSettings.active_team = randi_range(0, 1)
	print("Generated Team: " + str(GlobalSettings.active_team))
	SceneSwitcher.change_scene("res://scenes/team_turn.tscn")



func _on_exit_button_pressed():
	SceneSwitcher.quit_game()
	pass # Replace with function body.
