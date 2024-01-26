extends Node2D

func _ready():
	pass

func _on_next_button_pressed():
	SceneSwitcher.change_scene("res://scenes/team_turn.tscn", {"active_team":0})
