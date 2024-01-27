extends Node2D

func _ready():
	$CanvasLayer/TeamBTextureRect.visible = false

	_show_team_a()
	
	await get_tree().create_timer(2.0).timeout

	$CanvasLayer/TeamATextureRect.visible = false
	$CanvasLayer/TeamBTextureRect.visible = true
	
	_show_team_b()
	
	await get_tree().create_timer(2.0).timeout
	
	_on_next_button_pressed()

func _on_next_button_pressed():
	GlobalSettings.current_round +=1
	if GlobalSettings.current_round == GlobalSettings.total_rounds:
		SceneSwitcher.change_scene("res://scenes/results.tscn")
	else:
		SceneSwitcher.change_scene("res://scenes/team_turn.tscn")


func _show_team_a():
	
	var list_TeamA = GlobalSettings.list_TeamA
	for dictA in list_TeamA:
		var CardID = dictA["cardID"]
		var UserInput = dictA["userInput"]
		$CanvasLayer/TeamATextureRect/SpeechBubbleTextureRect/Label.text = UserInput
		_calculate_score(list_TeamA)
		
func _show_team_b():
	
	var list_TeamB = GlobalSettings.list_TeamB
	for dictB in list_TeamB:
		var CardID = dictB["cardID"]
		var UserInput = dictB["userInput"]
		$CanvasLayer/TeamBTextureRect/SpeechBubbleTextureRect/Label.text = UserInput
		_calculate_score(list_TeamB)
		
func _calculate_score(list_Team):
	for dictTeam in list_Team:
		dictTeam["score"] = 6969
		
		$CanvasLayer/DecibelOmeterTextureRect/ScoreLabel.text = str(dictTeam["score"])
