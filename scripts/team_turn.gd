extends Node2D

func _ready():
	var active_team = SceneSwitcher.get_param("active_team")
	print(active_team) 
	$CanvasLayer/ActivePlayer.text = "Active team: " + str(active_team)


func _on_next_button_pressed():
	# get variable
	var active_team = SceneSwitcher.get_param("active_team")

	if active_team == 0: # 0 Team A and 1 is Team B
		SceneSwitcher.change_scene("res://scenes/team_turn.tscn", {"active_team":1})
	elif  active_team == 1: # 0 Team A and 1 is Team B
		SceneSwitcher.change_scene("res://scenes/battle.tscn", {"active_team":0})
