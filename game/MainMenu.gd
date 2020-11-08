extends Control

signal start_game
signal end_game

onready var start_button = $VBoxContainer/StartGame
onready var end_button = $VBoxContainer/EndGame


func _on_StartGame_button_down():
	emit_signal("start_game")

func _on_EndGame_button_down():
	emit_signal("end_game")
