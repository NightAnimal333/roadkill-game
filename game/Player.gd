extends KinematicBody2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

var BASE_SPEED : float = 200

#The maximum value for velocity
var MAX_SPEED : float = 200

#The bigger this number - the more the car rotates when you change the y velocity
var ROTATION_X : float = 500

var velocity : Vector2 


# Called when the node enters the scene tree for the first time.
func _ready():
	velocity.x = self.global_position.x
	velocity.y = 0
	pass # Replace with function body.

func _process(delta):

	if Input.is_action_pressed("move_up"):
		if velocity.y > -MAX_SPEED:
			velocity.y -= BASE_SPEED * delta
	#		self.rotate(Vector2(self.position.x + 1, velocity.y).angle())		
			
	if Input.is_action_pressed("move_down"):
		if velocity.y < MAX_SPEED:
			velocity.y += BASE_SPEED * delta
	#		self.rotate(Vector2(self.position.x + 1, velocity.y).angle() * -1)
			
			
func _physics_process(_delta):
	move_and_slide(Vector2(0, velocity.y), Vector2(0, -1))
	self.look_at(Vector2(self.position.x + ROTATION_X, self.position.y + velocity.y))
	print(velocity)
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
