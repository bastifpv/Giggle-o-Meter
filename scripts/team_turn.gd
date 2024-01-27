extends Node2D

func _ready():
	#sets team numer to layout
	$CanvasLayer/PlayerInfo.text = "Team " + str(GlobalSettings.active_team) + "'s turn"


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
	


func card_pressed():
	$CanvasLayer/Cards.visible = false
	$CanvasLayer/PickACard.visible = false
	$CanvasLayer/SelectedCard.visible = true

func _on_card_1_pressed():
	card_pressed()
	print('press card 1')
	pass # Replace with function body.


func _on_card_2_pressed():
	card_pressed()
	print('press card 2')
	pass # Replace with function body.


func _on_card_3_pressed():
	card_pressed()
	print('press card 3')
	pass # Replace with function body.


func _on_button_confirm_round_pressed():
	print("call next player")
	pass # Replace with function body.
