extends Node2D


enum States {
	
	MainMenu,
	InitialiseLevel,
	RoadLevel,
	Pause
	
}

var game_state = States.InitialiseLevel
var current_level
var savegame = null
var player


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func _process(delta):
	if game_state == States.InitialiseLevel:
		current_level = load("res://Road.tscn").instance()
		self.add_child(current_level)
		game_state = States.RoadLevel

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
