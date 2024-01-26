extends Node2D

func _ready():
	#sets team numer to layout
	$CanvasLayer/ActivePlayer.text = "Active team: " + str(GlobalSettings.active_team)


func _on_next_button_pressed():
	#counts if both player have done their turn
	print(GlobalSettings.current_round)
	if GlobalSettings.count_both_players_turn < 1:
		#reverse the active team
		if GlobalSettings.active_team == 1:
			GlobalSettings.active_team = 0
		else: 
			GlobalSettings.active_team = 1
			
		#call other scene
		GlobalSettings.count_both_players_turn +=1 
		SceneSwitcher.change_scene("res://scenes/team_turn.tscn")
	else:
		GlobalSettings.count_both_players_turn = 0
		SceneSwitcher.change_scene("res://scenes/battle.tscn")
	


