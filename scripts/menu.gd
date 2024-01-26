extends Node2D

func _ready():
	pass

func _on_play_button_pressed():
	SceneSwitcher.change_scene("res://scenes/team_turn.tscn", {"active_team":0})



func _on_exit_button_pressed():
	SceneSwitcher.quit_game()
	pass # Replace with function body.
