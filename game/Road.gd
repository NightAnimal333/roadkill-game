extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

# Y-coordinate where the roadkill spawns
# TODO: Instead of this use screen boundaries or something
var ROADKILL_SPAWN_UP : float = 0
var ROADKILL_SPAWN_DOWN : float = 700

# How far away from the player the roadkill spawns (on x-axis)
var ROADKILL_SPAWN_DISTANCE_MIN : int = 500
var ROADKILL_SPAWN_DISTANCE_RANGE : int = 500

var max_roadkill : int = 5
var roadkill = []

onready var player = $Player


func remove_roadkill(roadkill_obj):
	roadkill.erase(roadkill_obj)


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	randomize()

	var generate_roadkill = randi() % 100
	if (generate_roadkill > 98) && (roadkill.size() < max_roadkill):
		roadkill.append(load("res://Actors/Roadkill.tscn").instance())
		self.add_child(roadkill[roadkill.size() - 1])
		
		#Either the roadkill will go upwards or downwards
		var direction = ((randi() % 2) * 2) - 1
		
		#How far away the roadkil will spawn on x-axis
		var distance = ROADKILL_SPAWN_DISTANCE_MIN + (randi() % ROADKILL_SPAWN_DISTANCE_RANGE)
		
		print(distance)
		
		#Downwards
		if direction == 1:
			roadkill[roadkill.size() - 1].initialise(Vector2(player.position.x + ROADKILL_SPAWN_DISTANCE_MIN, ROADKILL_SPAWN_UP), 500 * direction, 7, roadkill.size() - 1)
		
		#Upwards		
		elif direction == -1:
			roadkill[roadkill.size() - 1].initialise(Vector2(player.position.x + ROADKILL_SPAWN_DISTANCE_MIN, ROADKILL_SPAWN_DOWN), 500 * direction, 7, roadkill.size() - 1)
				
		roadkill[roadkill.size() - 1].connect("time_to_die", self, "remove_roadkill")
		
		
