extends KinematicBody2D

var velocity : Vector2
var y_speed : float

onready var timer = $Timer

"""
Spawn squirrel by using initialize with args:
	Position where to spawn, taking player as start point
		That means the position must be positive and negative
		For example: (400, -50)
	Speed.x compared to the car, value between 0 and 1
	Speed.y how fast it will fall down
	Spawn time how long until the squirrel spawns
"""

func _ready():
	pass
	initialize(Vector2(0, 0), 1,  100, 3)

func _process(delta):
	velocity.x = get_node("/root/Road/Player").velocity.x # Change later

func _physics_process(delta):
	velocity = move_and_slide(velocity)

func initialize(spawn_position : Vector2, new_x : float,
		new_y : float, spawn_time : int):
	var player = get_node("/root/Road/Player")
	timer.start(spawn_time)
	position = spawn_position + player.global_position
	y_speed = new_y

func _on_Timer_timeout():
	velocity.y = y_speed
	print ("My time to shine")
	print (velocity)
