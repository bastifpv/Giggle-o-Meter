extends Node2D

var dict = {}
var selectedCardID = 0

func _ready():
	#sets team numer to layout
	$CanvasLayer/PlayerInfo.text = "Team " + str(GlobalSettings.active_team) + "'s turn"



func card_pressed():
	$CanvasLayer/Cards.visible = false
	$CanvasLayer/PickACard.visible = false
	$CanvasLayer/SelectedCard.visible = true

func _on_card_1_pressed():
	selectedCardID = 1
	card_pressed()
	print('press card 1')
	pass # Replace with function body.


func _on_card_2_pressed():
	selectedCardID = 2
	card_pressed()
	print('press card 2')
	pass # Replace with function body.


func _on_card_3_pressed():
	selectedCardID = 3
	card_pressed()
	print('press card 3')
	pass # Replace with function body.


func _on_button_confirm_round_pressed():
	dict = {'cardID' : selectedCardID, 'userInput' : $CanvasLayer/SelectedCard/TextureRect/UserInputField.text }
	print("call next player")
	print(dict)
	if GlobalSettings.count_both_players_turn < 1:
		#reverse the active team
		if GlobalSettings.active_team == 1:
			GlobalSettings.list_TeamA.append(dict)
			GlobalSettings.active_team = 0
		else: 
			GlobalSettings.list_TeamB.append(dict)
			GlobalSettings.active_team = 1
			
		#call other scene
		GlobalSettings.count_both_players_turn +=1 
		SceneSwitcher.change_scene("res://scenes/team_turn.tscn")
	else:
		GlobalSettings.count_both_players_turn = 0
		SceneSwitcher.change_scene("res://scenes/battle.tscn")
	pass # Replace with function body.
