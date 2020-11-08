extends Node2D


enum States {
	
	MainMenu,
	InitialiseLevel,
	RoadLevel,
	Pause
	
}

var game_state = States.MainMenu
var current_level
var menu
var savegame = null
var player


onready var game_music_player = $GameMusicPlayer
onready var splat_sound = $SplatSoundPlayer


func _ready():
	state_machine(States.MainMenu)

func state_machine(state):
	game_state = state
	match game_state:
		States.MainMenu:
			menu = load("res://MainMenu.tscn").instance()
			self.add_child(menu)
			menu.connect("start_game", self, "start_game")
			menu.connect("end_game", self, "end_game")
		States.InitialiseLevel:
			current_level = load("res://Road.tscn").instance()
			self.add_child(current_level)
			game_state = States.RoadLevel
			current_level.connect("level_over", self, "restart_level")

func start_game():
	menu.queue_free()
	state_machine(States.InitialiseLevel)

func end_game():
	get_tree().quit()

func restart_level():
	splat_sound.play()
	game_music_player.seek(6.0)
	state_machine(States.InitialiseLevel)

func _on_GameMusicPlayer_finished():
	game_music_player.play()

