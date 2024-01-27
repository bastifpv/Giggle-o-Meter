extends Node2D

var array = []

func _ready():
	
	print(GlobalSettings.list_TeamA)
	print(GlobalSettings.list_TeamB)
	print(GlobalSettings.current_round)
	$CanvasLayer/TeamBTextureRect.visible = false
	$CanvasLayer/TeamATextureRect.visible = true
	_show_team_a()
	_play_sound()
	await get_tree().create_timer(3.0).timeout
	_audio_to_score()
	
	await get_tree().create_timer(2.0).timeout

	$CanvasLayer/TeamATextureRect.visible = false
	$CanvasLayer/TeamBTextureRect.visible = true
	
	_show_team_b()
	
	#await get_tree().create_timer(2.0).timeout
	
	#_on_next_button_pressed()

func _process(delta):
	if (AudioServer.get_bus_peak_volume_left_db(AudioServer.get_bus_index("Record"),0) > -180):
			array.append(AudioServer.get_bus_peak_volume_left_db(AudioServer.get_bus_index("Record"),0))
	

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
	
	
func _play_sound():
	$ExampleAUdio.play()
	print("audioDOne")
	
func _audio_to_score():
	var score = 0
	var scoreArr = []
	var in_min = -200
	var in_max = 0
	var out_max = 100
	var out_min = 0
	var counter = 0
	for x in array:
		var calcedValue = (x - in_min) * (out_max - out_min) / (in_max - in_min) + out_min
		scoreArr.append(calcedValue)
		score += calcedValue
		counter +=1
	var final_score = score / counter
	print(final_score)
	return final_score
	
	
func _paly_text():
	pass
