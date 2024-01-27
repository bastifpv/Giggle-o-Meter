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
	
	# get arrays with stats from all played rounds
	for i in results_TeamA:
		cardIDs_TeamA.append(i["cardID"])
		userInput_TeamA.append(i["userInput"])
		score_TeamA.append(i["score"])
		
	
	# get arrays with stats from all played rounds
	for j in results_TeamB:
		cardIDs_TeamB.append(j["cardID"])
		userInput_TeamB.append(j["userInput"])
		score_TeamB.append(j["score"])
		
	# calculate total score and compare
	var total_score_TeamA = 0
	for s in score_TeamA:
		total_score_TeamA += s
	
	var total_score_TeamB = 0
	for s in score_TeamB:
		total_score_TeamB += s
		
	# evaluate winner
	if total_score_TeamA > total_score_TeamB:
		$CanvasLayer/WinnerLabel.text = "The winner is Team A with a score of " + str(total_score_TeamA) + "!" 
	elif total_score_TeamA < total_score_TeamB:
		$CanvasLayer/WinnerLabel.text = "The winner is Team B with a score of " + str(total_score_TeamB) + "!" 
	elif total_score_TeamA == total_score_TeamB:
		$CanvasLayer/WinnerLabel.text =  "It is a draw! Both teams win."
		
		
	$CanvasLayer/CardsALabel.text = str(cardIDs_TeamA)
	$CanvasLayer/userInputALabel.text = str(userInput_TeamA)
	$CanvasLayer/scoreALabel.text = str(score_TeamA)
		
	$CanvasLayer/CardsBLabel.text = str(cardIDs_TeamB)
	$CanvasLayer/userInputBLabel.text = str(userInput_TeamB)
	$CanvasLayer/scoreBLabel.text = str(score_TeamB)
				
func _on_next_button_pressed():
	print("Game finished")
	#SceneSwitcher.change_scene("res://scenes/team_turn.tscn", {"active_team":0})
