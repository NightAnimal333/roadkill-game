extends KinematicBody2D

var velocity : Vector2
var y_speed : float

onready var timer = $Timer


func _ready():
	initialize(Vector2(1000, -400), 1,  100, 3)

func _process(delta):
	velocity.x = get_node("/root/Road/Player").velocity.x # Change later
	print (str(get_node("/root/Road/Player").global_position))
	pass
	

func _physics_process(delta):
	velocity = move_and_slide(velocity)

func initialize(spawn_position : Vector2, new_y : float,
		new_x : float, spawn_time : int):
	timer.start(spawn_time)
	position = spawn_position
	y_speed = new_y

func _on_Timer_timeout():
	velocity.y = y_speed
