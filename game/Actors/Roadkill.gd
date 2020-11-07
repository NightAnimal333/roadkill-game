extends KinematicBody2D

#var velocity : Vector2
var y_speed : float = 100
#var player 
var ID : int

onready var timer = $Timer
onready var sprite = $Sprite
signal time_to_die(object)

"""
Spawn squirrel by using initialize with args:
	Position where to spawn, taking player as start point
		That means the position must be positive and negative
		For example: (400, -50)
	Speed.x compared to the car, value between 0 and 1
	Speed.y how fast it will fall down
	Spawn time how long until the squirrel spawns
"""

#var spawn_position : Vector2 = Vector2(300, 0)

func _ready():
	
	pass
#	initialize(spawn_position, 1,  100, 3)

func _process(delta):
	
	pass
	#velocity.x = player.velocity.x # Change later

func _physics_process(delta):
	move_and_slide(Vector2(0, y_speed))

func initialise(spawn_position : Vector2, new_y_speed : float, life_time : int, new_ID : int):
	timer.start(life_time)
	self.position = spawn_position
	y_speed = new_y_speed
	self.ID = new_ID
	
	if y_speed >=0:
		sprite.animation = "down"
	else:
		sprite.animation = "up"
	
	return self

func _on_Timer_timeout():
	#velocity.y = y_speed
	print ("My time to shine")
	emit_signal("time_to_die", self)
	self.queue_free()	
	#print (velocity)
