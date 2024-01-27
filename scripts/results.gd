extends Node2D

func _ready():
	var results_TeamA = GlobalSettings.list_TeamA
	var cardIDs_TeamA = []
	var userInput_TeamA = []
	var score_TeamA = []
	
	var results_TeamB = GlobalSettings.list_TeamB
	var cardIDs_TeamB = []
	var userInput_TeamB = []
	var score_TeamB = []
	
	
	for i in results_TeamA:
		cardIDs_TeamA.append(i["cardID"])
		userInput_TeamA.append(i["userInput"])
		score_TeamA.append(i["score"])
		
	
		
	for j in results_TeamB:
		cardIDs_TeamB.append(j["cardID"])
		userInput_TeamB.append(j["userInput"])
		score_TeamB.append(j["score"])
		
		
	$CanvasLayer/CardsALabel.text = str(cardIDs_TeamA)
	$CanvasLayer/userInputALabel.text = str(userInput_TeamA)
	$CanvasLayer/scoreALabel.text = str(score_TeamA)
		
	$CanvasLayer/CardsBLabel.text = str(cardIDs_TeamB)
	$CanvasLayer/userInputBLabel.text = str(userInput_TeamB)
	$CanvasLayer/scoreBLabel.text = str(score_TeamB)

func _on_next_button_pressed():
	print("Game finished")
	#SceneSwitcher.change_scene("res://scenes/team_turn.tscn", {"active_team":0})
