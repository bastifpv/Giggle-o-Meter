extends Node2D

func _ready():
	print(GlobalSettings.list_TeamA)
	print(GlobalSettings.list_TeamB)
	print(GlobalSettings.current_round)
	$CanvasLayer/TeamBTextureRect.visible = false
	$CanvasLayer/TeamATextureRect.visible = true
	_show_team_a()
	
	_play_text(GlobalSettings.list_TeamA[GlobalSettings.current_round].get("userInput"), 120)
	
	await get_tree().create_timer(2.0).timeout

	$CanvasLayer/TeamATextureRect.visible = false
	$CanvasLayer/TeamBTextureRect.visible = true
	
	_show_team_b()
	
	_play_text(GlobalSettings.list_TeamB[GlobalSettings.current_round].get("userInput"), 120)
	
	#await get_tree().create_timer(2.0).timeout
	
	#_on_next_button_pressed()

func _on_next_button_pressed():
	GlobalSettings.current_round +=1
	if GlobalSettings.current_round == GlobalSettings.total_rounds:
		SceneSwitcher.change_scene("res://scenes/results.tscn")
	else:
		SceneSwitcher.change_scene("res://scenes/team_turn.tscn")


func _show_team_a():
	var list_TeamA = GlobalSettings.list_TeamA
	
	var dictA = list_TeamA[GlobalSettings.current_round]
	var CardID = dictA["cardID"]
	var UserInput = dictA["userInput"]
	$CanvasLayer/TeamATextureRect/SpeechBubbleTextureRect/Label.text = UserInput
	_calculate_score(list_TeamA)
		
func _show_team_b():
	var list_TeamB = GlobalSettings.list_TeamB
	var dictB = list_TeamB[GlobalSettings.current_round]
	var CardID = dictB["cardID"]
	var UserInput = dictB["userInput"]
	$CanvasLayer/TeamBTextureRect/SpeechBubbleTextureRect/Label.text = UserInput
	_calculate_score(list_TeamB)
		
func _calculate_score(list_Team):
	for dictTeam in list_Team:
		dictTeam["score"] = 6969
		print(" ===" + str(dictTeam))
		$CanvasLayer/DecibelOmeterTextureRect/ScoreLabel.text = str(dictTeam["score"])

func _record_sound():
	pass
	
func _analyse_sound():
	pass
	
func _play_text(text, voiceNr):
	var voices = DisplayServer.tts_get_voices_for_language("en")
	var voice_id = voices[int(voiceNr)]

	# Say "Hello, world!".
	DisplayServer.tts_speak(str(text), voice_id)

