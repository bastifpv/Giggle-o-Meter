extends Node2D

var effect  # See AudioEffect in docs
var recording  # See AudioStreamSample in docs

var stereo := true
var mix_rate := 44100  # This is the default mix rate on recordings
var format := 1  # This equals to the default format: 16 bits

func _ready():
	
	var list_TeamA = GlobalSettings.list_TeamA
	var list_TeamB = GlobalSettings.list_TeamB
	
	print(list_TeamA)
	print(list_TeamB)
	print(GlobalSettings.current_round)
	
	# make team A visible and make Team B invisible, Decibel-O-Meter invisible
	$CanvasLayer/TeamATextureRect.visible = true
	$CanvasLayer/TeamBTextureRect.visible = false
	$CanvasLayer/DecibelOmeterTextureRect.visible = false
	
	# show user input team A
	_show_team_a()
	
	# Decibel-O-Meter visible
	$CanvasLayer/DecibelOmeterTextureRect.visible = true
	
	# record audio team A
	_record_sound()
	
	_analyse_sound()
	await get_tree().create_timer(5.0).timeout
	
	# show results team A
	_calculate_score(list_TeamA)

	# make team A invisible and make Team B visible, Decibel-O-Meter invisible
	$CanvasLayer/TeamATextureRect.visible = false
	$CanvasLayer/TeamBTextureRect.visible = true
	$CanvasLayer/DecibelOmeterTextureRect.visible = false
	
	# show user input team B
	_show_team_b()
	
	# Decibel-O-Meter visible
	$CanvasLayer/DecibelOmeterTextureRect.visible = true
	
	# record audio team A
	_record_sound()
	
	_analyse_sound()
	await get_tree().create_timer(5.0).timeout
	
	# show results team B
	_calculate_score(list_TeamB)
	


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
	#_calculate_score(list_TeamA)
		
func _show_team_b():
	var list_TeamB = GlobalSettings.list_TeamB
	var dictB = list_TeamB[GlobalSettings.current_round]
	var CardID = dictB["cardID"]
	var UserInput = dictB["userInput"]
	$CanvasLayer/TeamBTextureRect/SpeechBubbleTextureRect/Label.text = UserInput
	#_calculate_score(list_TeamB)
		
func _calculate_score(list_Team):
	for dictTeam in list_Team:
		dictTeam["score"] = 6969
		print(" ===" + str(dictTeam))
		$CanvasLayer/DecibelOmeterTextureRect/ScoreLabel.text = str(dictTeam["score"])

func _record_sound():
	print("Recording started...")
	var idx = AudioServer.get_bus_index("Record")
	effect = AudioServer.get_bus_effect(idx, 0)
	
	# recording for team A
	#if GlobalSettings.active_team == 0:
	# print("Recording active team 0...")
	
	#print("Recording object: " + str(recording))
	print("Is Recording active?: " + str(effect.is_recording_active()))
	# start recording
	effect.set_recording_active(true)
	await get_tree().create_timer(3.0).timeout
	
	# stop recording
	effect.set_recording_active(false)
	print("Is Recording active still?: " + str(effect.is_recording_active()))
	
	recording = effect.get_recording()
	print("Recording object: " + str(recording))

	

	print("Saving...")
	# save recording
	_save_recording()
	
	print("Playback...")
	
	$AudioStreamPlayer.stream = recording
	$AudioStreamPlayer.play()
	
func _analyse_sound():
	pass
	
func _play_text():
	pass

func _save_recording():
	# var save_path = "res://assets/audio_recording.wav"
	var save_path = "user://record.wav"
	recording.save_to_wav(save_path)
	
	print("Status: Saved WAV file to: %s\n(%s)" % [save_path, ProjectSettings.globalize_path(save_path)]) 
