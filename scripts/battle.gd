extends Node2D

var effect  # See AudioEffect in docs
var recording  # See AudioStreamSample in docs

var stereo := true
var mix_rate := 44100  # This is the default mix rate on recordings
var format := 1  # This equals to the default format: 16 bits

var array = []

var readyTeam = false

func _ready():
	
	var list_TeamA = GlobalSettings.list_TeamA
	var list_TeamB = GlobalSettings.list_TeamB
	
	
	_show_team_a()
	_play_player_a()
	await get_tree().create_timer(5.5).timeout

	# record audio team A
	_record_sound()
	await get_tree().create_timer(3.5).timeout
	
	# analyze sound
	$Tracker.stream = recording
	$Tracker.play()
	
   #wait because fade
	await get_tree().create_timer(1.0).timeout
	# show results team A
	#_set_final_scoreA(50)
	print(_audio_to_score())
	_set_final_scoreA(_audio_to_score())
		
	await get_tree().create_timer(2.0).timeout
	
	$CanvasLayer/ProgressBar.value = 0
	
	array = []
	
	# make team A invisible and make Team B visible, Decibel-O-Meter invisible
	# show user input team B
	_show_team_b()
	
	_play_player_b()
	
	await get_tree().create_timer(5.5).timeout
	
	# Decibel-O-Meter visible
	$CanvasLayer/ProgressBar.visible = true
	
	# record audio team B
	_record_sound()
	await get_tree().create_timer(3.5).timeout
	
	# analyze sound
	$Tracker.stream = recording
	$Tracker.play()
	
   #wait because fade
	await get_tree().create_timer(1.0).timeout
	
	# show results team B
	#_set_final_scoreA(50)
	print(_audio_to_score())
	_set_final_scoreB(_audio_to_score())
		
	await get_tree().create_timer(2.0).timeout
	
	_on_next_button_pressed()
	

func _process(delta):
	#print("Process function")
	if (AudioServer.get_bus_peak_volume_left_db(AudioServer.get_bus_index("Tracker"),0) > -190):
		var data = AudioServer.get_bus_peak_volume_left_db(AudioServer.get_bus_index("Tracker"),0)
		array.append(data)
		#print("Data array:" + str(data))

func _play_player_a():
	var text = str(GlobalSettings.list_TeamA[GlobalSettings.current_round].get("cardData")).replace("__________", str(GlobalSettings.list_TeamA[GlobalSettings.current_round].get("userInput")))
	print(text)
	if OS.get_name() == "Linux":
		_play_text(text, 120)
	elif OS.get_name() == "Windows":
		_play_text(text, 0)
	elif OS.get_name() == "Android":
		_play_text(text, 0)
	
func _play_player_b():
	var text = str(GlobalSettings.list_TeamB[GlobalSettings.current_round].get("cardData")).replace("__________", str(GlobalSettings.list_TeamB[GlobalSettings.current_round].get("userInput")))
	print(text)
	if OS.get_name() == "Linux":
		_play_text(text, 120)
	elif OS.get_name() == "Windows":
		_play_text(text, 0)
	elif OS.get_name() == "Android":
		_play_text(text, 0)
			

func _on_next_button_pressed():
	GlobalSettings.current_round +=1
	if GlobalSettings.current_round == GlobalSettings.total_rounds:
		SceneSwitcher.change_scene("res://scenes/results.tscn")
	else:
		SceneSwitcher.change_scene("res://scenes/team_turn.tscn")


func _show_team_a():
	# make team A visible and make Team B invisible, Decibel-O-Meter invisible
	$CanvasLayer/TeamATextureRect.visible = true
	$CanvasLayer/TeamBTextureRect.visible = false
	var list_TeamA = GlobalSettings.list_TeamA
	
	var dictA = list_TeamA[GlobalSettings.current_round]
	var CardID = dictA["cardID"]
	var CardData = dictA["cardData"]
	var UserInput = dictA["userInput"]
	var completeText = CardData.replace("__________", "[b] " + str(UserInput) + "[/b]")
	#print(completeText)
	$CanvasLayer/TeamATextureRect/SpeechBubbleTextureRect/RichTextLabel.text = "[color=black] " + str(completeText) + " [/color]"
		
func _show_team_b():
	$CanvasLayer/TeamATextureRect.visible = false
	$CanvasLayer/TeamBTextureRect.visible = true
	var list_TeamB = GlobalSettings.list_TeamB
	var dictB = list_TeamB[GlobalSettings.current_round]
	var CardID = dictB["cardID"]
	var CardData = dictB["cardData"]
	var UserInput = dictB["userInput"]
	var completeText = CardData.replace("__________", "[b] " + str(UserInput) + "[/b]")
	#print(completeText)
	$CanvasLayer/TeamBTextureRect/SpeechBubbleTextureRect/RichTextLabel.text = "[color=black] " + str(completeText) + " [/color]"
		

func _record_sound():
	print("Recording started...")
	var idx = AudioServer.get_bus_index("Record")
	effect = AudioServer.get_bus_effect(idx, 0)
	
	
	effect.set_recording_active(true)
	await get_tree().create_timer(3.0).timeout
	effect.set_recording_active(false)
	
	recording = effect.get_recording()

	

	#print("Saving...")
	# save recording
	#_save_recording()
	
	#print("Playback...")
	
	#$AudioStreamPlayer.stream = recording
	#$AudioStreamPlayer.play()
	
func _analyse_sound():
	pass

func _save_recording():
	# var save_path = "res://assets/audio_recording.wav"
	var save_path = "user://record.wav"
	recording.save_to_wav(save_path)
	
	print("Status: Saved WAV file to: %s\n(%s)" % [save_path, ProjectSettings.globalize_path(save_path)]) 

func _play_text(text, voiceNr):
	var voices = DisplayServer.tts_get_voices_for_language("en")
	var voice_id = voices[int(voiceNr)]

	# Say "Hello, world!".
	DisplayServer.tts_speak(str(text), voice_id)

func _audio_to_score():
	var score = 0
	var scoreArr = []
	var in_min = -70
	var in_max = -10
	var out_max = 100
	var out_min = 0
	var counter = 0
	if array.size() == 0:
		return 0
		
	array.sort()
	
		
	for x in array:
		
		#var calcedValue = ( (x - in_min) * (out_max - out_min) / (in_max - in_min) ) + out_min
		var calcedValue = mapToScale(x)
		scoreArr.append(calcedValue)
		score += calcedValue
		counter +=1
		
	scoreArr.sort()
	#print("Normalized Array: "+str(scoreArr))
	#print("Raw Array: "+str(array))
	#print("largest value: "+str(scoreArr[-1]))
	
	var final_score = scoreArr[int(counter/2)]
	if final_score >= 100:
		final_score = 100
	if final_score <= 0:
		final_score = 0
	#var final_score = score / counter
	#print(final_score)
	return int(final_score)
	
func mapToScale(dBValue):
	var dBMin = -180
	var mappedValue = -10 * log(dBValue / dBMin) / log(10)
	# Ensure the mapped value stays within the 1 to 100 range
	mappedValue = clamp(mappedValue, 1, 100)
	return mappedValue *10


func _set_final_scoreA(score):
	var dict = GlobalSettings.list_TeamA[GlobalSettings.current_round]
	GlobalSettings.list_TeamA[GlobalSettings.current_round]["score"] = score
	$CanvasLayer/ProgressBar/ScoreLabel.text = str(dict["score"])
	$CanvasLayer/ProgressBar.value = score
	
func _set_final_scoreB(score):
	var dict = GlobalSettings.list_TeamB[GlobalSettings.current_round]
	GlobalSettings.list_TeamB[GlobalSettings.current_round]["score"] = score
	$CanvasLayer/ProgressBar/ScoreLabel.text = str(dict["score"])
	$CanvasLayer/ProgressBar.value = score


func _on_ready_button_pressed():
	readyTeam = true
