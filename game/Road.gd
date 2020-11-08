extends Node2D

signal level_over(cause)

# Y-coordinate where the roadkill spawns
# TODO: Instead of this use screen boundaries or something
var ROADKILL_SPAWN_UP : float = 0
var ROADKILL_SPAWN_DOWN : float = 700

# How far away from the player the roadkill spawns (on x-axis)
var ROADKILL_SPAWN_DISTANCE_MIN : int = 800
var ROADKILL_SPAWN_DISTANCE_RANGE : int = 500

# How far away from the player the roadkill spawns (on x-axis)
var BYPASSER_SPAWN_DISTANCE : int = 800

var max_roadkill : int = 5
var roadkill = []

var bypassers = []

onready var player = $Player
onready var road_zones = $RoadZones

func remove_roadkill(roadkill_obj):
	roadkill.erase(roadkill_obj)


func _ready():
	player.connect("player_lost", self, "emit_level_over")


func _process(delta):
	road_zones.position.x = player.position.x - 500
	
	self.generate_roadkill()
	self.generate_bypasser()


func generate_bypasser():
	randomize()
	
	var generate_bypasser = randi() % 500
	if (generate_bypasser > 495):
		bypassers.append(load("res://Actors/Bypasser.tscn").instance())
		self.add_child(bypassers[bypassers.size() - 1])
		
		var lane = randi() % 2	
		
		#Fix the hardcoded numbers
		#Downwards
		if lane == 0:
			bypassers[bypassers.size() - 1].position = Vector2(1606 + player.position.x, 344)
		
		#Upwards		
		elif lane == 1:
			bypassers[bypassers.size() - 1].position = Vector2(1814 + player.position.x, 253)
				


func generate_roadkill():
	randomize()
	
	var generate_roadkill = randi() % 100
	if (generate_roadkill > 98) && (roadkill.size() < max_roadkill):
		roadkill.append(load("res://Actors/Roadkill.tscn").instance())
		self.add_child(roadkill[roadkill.size() - 1])
		
		#Either the roadkill will go upwards or downwards
		var direction = ((randi() % 2) * 2) - 1
		
		#How far away the roadkil will spawn on x-axis
		var distance = ROADKILL_SPAWN_DISTANCE_MIN + (randi() % ROADKILL_SPAWN_DISTANCE_RANGE)
	
		var type = ""
	
		var generate_type = randi() % 7
		match generate_type:
			0:
				type = "rabbit"
			1:
				type = "cow"
			2:
				type = "bear"
			3:
				type = "fox"
			4:
				type = "cat_white"
			5:
				type = "cat_black"
			6:
				type = "cat_brown"
			7:
				type = "cat_beige"
		
		#Downwards
		if direction == 1:
			roadkill[roadkill.size() - 1].initialise(Vector2(player.position.x + ROADKILL_SPAWN_DISTANCE_MIN, ROADKILL_SPAWN_UP), 500 * direction, 7, type)
		
		#Upwards		
		elif direction == -1:
			roadkill[roadkill.size() - 1].initialise(Vector2(player.position.x + ROADKILL_SPAWN_DISTANCE_MIN, ROADKILL_SPAWN_DOWN), 500 * direction, 7, type)
				
		roadkill[roadkill.size() - 1].connect("time_to_die", self, "remove_roadkill")

func emit_level_over(cause):
	print("You dead!: " + cause)
	emit_signal("level_over", cause)
	self.queue_free()
