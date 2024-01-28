extends Node2D

func _ready():
	$Options/Label.text = str(GlobalSettings.total_rounds) + " rounds per game"
	pass

func _on_play_button_pressed():
	GlobalSettings.active_team = randi_range(0, 1)
	print("Generated Team: " + str(GlobalSettings.active_team))
	SceneSwitcher.change_scene("res://scenes/team_turn.tscn")



func _on_exit_button_pressed():
	SceneSwitcher.quit_game()
	pass # Replace with function body.


func _on_back_button_pressed():
	$Options.visible = false
	$CanvasLayer.visible = true
	pass # Replace with function body.


func _on_options_button_pressed():
	$Options.visible = true
	$CanvasLayer.visible = false
	pass # Replace with function body.


func _on_h_slider_drag_ended(value_changed):
	GlobalSettings.total_rounds = $Options/HSlider.value
	$Options/Label.text = str(GlobalSettings.total_rounds) + " rounds per game"
	pass # Replace with function body.
