extends Control

signal start_game
signal end_game

func _on_StartGame_button_down():
	emit_signal("start_game")

func _on_EndGame_button_down():
	emit_signal("end_game")
