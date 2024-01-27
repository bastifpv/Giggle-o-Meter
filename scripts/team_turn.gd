extends Node2D

var database = load("res://scripts/database.gd").new()

# get random 3 cards
var cards = database.pick_random_cards()
var cardData1 = cards[0]
var cardData2 = cards[1]
var cardData3 = cards[2]


var dict = {}
var selectedCardID = 0

func _ready():
	#sets team numer to layout
	$CanvasLayer/PlayerInfo.text = "Team " + str(GlobalSettings.active_team) + "'s turn"
	
	
	
	$CanvasLayer/Cards/Card1/Card1RichTextLabel.text = str(cardData1["asset"])
	$CanvasLayer/Cards/Card2/Card2RichTextLabel.text = str(cardData2["asset"])
	$CanvasLayer/Cards/Card3/Card3RichTextLabel.text = str(cardData3["asset"])

func card_pressed():
	$CanvasLayer/Cards.visible = false
	$CanvasLayer/PickACard.visible = false
	$CanvasLayer/SelectedCard.visible = true
	
	$CanvasLayer/SelectedCard/TextureRect/SelectedCardInfoRichTextLabel.text = "[color=black]" + str(database.get_card_info(selectedCardID)[0]["asset"]) + "[/color]"
	
func _on_card_1_pressed():
	selectedCardID = cardData1["cardID"]
	card_pressed()
	print('press card 1')
	pass # Replace with function body.


func _on_card_2_pressed():

	selectedCardID = cardData2["cardID"]
	card_pressed()
	print('press card 2')
	pass # Replace with function body.


func _on_card_3_pressed():
	selectedCardID = cardData3["cardID"]
	card_pressed()
	print('press card 3')
	pass # Replace with function body.


func _on_button_confirm_round_pressed():
	
	if $CanvasLayer/SelectedCard/TextureRect/UserInputField.text.is_empty():
		print("Text ")
		return
	dict = {'cardID' : selectedCardID, 'cardData' : str(database.get_card_info(selectedCardID)[0]["asset"]), 'userInput' : $CanvasLayer/SelectedCard/TextureRect/UserInputField.text }
	#print(dict)
	print("-=-=-=-=-" + str(GlobalSettings.count_both_players_turn))
	
	print("Active Team: " + str(GlobalSettings.active_team))
	if GlobalSettings.active_team == 0:
		print("Team 0")
		GlobalSettings.list_TeamA.append(dict)
		GlobalSettings.active_team = 1
	
	elif GlobalSettings.active_team == 1: 
		print("Team 1")
		GlobalSettings.list_TeamB.append(dict)
		GlobalSettings.active_team = 0

	if GlobalSettings.count_both_players_turn < 1:
		#reverse the active team		
		#call other scene
		GlobalSettings.count_both_players_turn +=1 
		
		SceneSwitcher.change_scene("res://scenes/team_turn.tscn")
	else:
		GlobalSettings.count_both_players_turn = 0
		SceneSwitcher.change_scene("res://scenes/battle.tscn")
	
