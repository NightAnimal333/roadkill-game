extends KinematicBody2D

var y_speed : float = 100
var type : String

onready var timer = $Timer
onready var sprite = $Sprite
signal time_to_die(object)

func _ready():
	pass

func _process(delta):
	pass


func _physics_process(delta):
	move_and_slide(Vector2(0, y_speed))

func initialise(spawn_position : Vector2, new_y_speed : float, life_time : int, new_type : String):
	
	timer.start(life_time)
	self.position = spawn_position
	y_speed = new_y_speed
	type = new_type
	
	if y_speed >=0:
		sprite.animation = type + "_down"
	else:
		sprite.animation = type + "_up"
	
	return self

func _on_Timer_timeout():
	emit_signal("time_to_die", self)
	self.queue_free()	


func _on_Hitbox_hit_by_car():
	emit_signal("time_to_die", self)
	self.queue_free()	
