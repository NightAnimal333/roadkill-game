extends Node2D

signal level_over(cause, stats)

onready var warning_sign = preload("res://Warning.tscn")

var DISTANCE_TO_WIN : float = 10000

# Y-coordinate where the roadkill spawns
# TODO: Instead of this use screen boundaries or something
var ROADKILL_SPAWN_UP : float = 0
var ROADKILL_SPAWN_DOWN : float = 900

# How far away from the player the roadkill spawns (on x-axis)
var ROADKILL_SPAWN_DISTANCE_MIN : int = 600
var ROADKILL_SPAWN_DISTANCE_RANGE : int = 500

# How far away from the player the roadkill spawns (on x-axis)
var BYPASSER_SPAWN_DISTANCE : int = 800

var max_roadkill : int = 5
var roadkill = []

var bypassers = []

var player_statistics = {"Distance traveled": 0.0,
						"Time traveled": 0.0,
						"Time in opposite lane": 0.0,
						"Maximum speed": 0.0}

var is_player_in_opposite : bool = false

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
	
	player_statistics["Distance traveled"] += player.traveled
	player_statistics["Time traveled"] += delta
	if player.calculated_speed > player_statistics["Maximum speed"]:
		player_statistics["Maximum speed"] = player.calculated_speed
	
	if (player.traveled > DISTANCE_TO_WIN):
		emit_signal("level_over", "victory_distance", player.traveled)
		self.queue_free()
		
	if is_player_in_opposite:
		player_statistics["Time in opposite lane"] += delta
	

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
		# How far away the roadkil will spawn on x-axis
		var distance = ROADKILL_SPAWN_DISTANCE_MIN + (randi() % ROADKILL_SPAWN_DISTANCE_RANGE)
		
		# Either the roadkill will go upwards or downwards
		var direction = ((randi() % 2) * 2) - 1
		
		# Add a warning sign so player can prepare
		var warn_sign = warning_sign.instance()
		var player_pos = player.global_position
		warn_sign.position.x = player_pos.x + distance
		if direction == 1:
			warn_sign.position.y = -550
		elif direction == -1:
			warn_sign.position.y = 150
		self.add_child(warn_sign)
		
		yield(get_tree().create_timer(2.0), "timeout")
		
		warn_sign.queue_free()
		
		roadkill.append(load("res://Actors/Roadkill.tscn").instance())
		
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

		
		self.add_child(roadkill[roadkill.size() - 1])
		
		
		#Downwards
		if direction == 1:
			roadkill[roadkill.size() - 1].initialise(Vector2(player.position.x + distance, ROADKILL_SPAWN_UP), 500 * direction, 7, type)
		
		#Upwards		
		elif direction == -1:
			roadkill[roadkill.size() - 1].initialise(Vector2(player.position.x + distance, ROADKILL_SPAWN_DOWN), 500 * direction, 7, type)
				
		roadkill[roadkill.size() - 1].connect("time_to_die", self, "remove_roadkill")
		

func emit_level_over(cause):
	print("You dead!: " + cause)
	emit_signal("level_over", cause, player_statistics)
	self.queue_free()


func _on_OppositeLaneZone_area_entered(area):
	if(area.is_in_group("Player")):
		self.is_player_in_opposite = true


func _on_OppositeLaneZone_area_exited(area):
	if(area.is_in_group("Player")):	
		self.is_player_in_opposite = false
