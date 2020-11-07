extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

var max_roadkill : int = 5
var roadkill = []

onready var player = $Player

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	randomize()
	print (roadkill.size())

	var generate_roadkill = randi() % 100
	if (generate_roadkill > 98) && (roadkill.size() < max_roadkill):
		roadkill.append(load("res://Actors/Roadkill.tscn").instance())
		self.add_child(roadkill[roadkill.size() - 1])
		
		roadkill[roadkill.size() - 1].initialise(Vector2(player.position.x + 300, 0), 500, 7)
		#self.connect("time_to_die", roadkill[roadkill.size() - 1], pop_ro)
		

