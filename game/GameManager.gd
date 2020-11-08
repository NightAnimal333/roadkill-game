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

onready var game_music_player = $GameMusicPlayer
onready var splat_sound_player = $SplatSoundPlayer

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func _process(delta):
	if game_state == States.InitialiseLevel:
		current_level = load("res://Road.tscn").instance()
		self.add_child(current_level)
		game_state = States.RoadLevel
		current_level.connect("level_over", self, "restart_level")

func restart_level(cause_of_death):
	match cause_of_death:
		splat_sound_player.play()
		game_music_player.seek(6.0)
		game_state = States.InitialiseLevel

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_GameMusicPlayer_finished():
	game_music_player.play()
	pass # Replace with function body.
