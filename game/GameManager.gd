extends Node2D


enum States {
	
	MainMenu,
	RoadLevel,
	Pause
	
}

var game_state = States.RoadLevel
var current_level
var savegame = null
var player


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
