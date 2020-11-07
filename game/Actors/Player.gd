extends KinematicBody2D

#<<<<<<< HEAD
#var speed = 200
#var velocity = Vector2()
#
#func _physics_process(delta):
#	if Input.is_action_pressed("ui_right"):
#		velocity.x = speed
#	else:
#		velocity.x = 0
#
#	velocity = move_and_slide(velocity)
#
#
#func _on_Area2D_body_entered(body):
#	if body.is_in_group("Animal"):
#		body.queue_free()
#=======


var BASE_SPEED : float = 200

#The maximum value for Y-axis velocity
var MAX_SPEED : float = 200

#How fast the car moves on X-axis
var X_SPEED_MULTIPLIER : float = 0.7

#The bigger this number - the less the car rotates when you change the y velocity
var ROTATION_X : float = 1000

var velocity : Vector2 

func _ready():
	velocity.x = self.global_position.x
	velocity.y = 0

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
	move_and_slide(Vector2(velocity.x * X_SPEED_MULTIPLIER, velocity.y), Vector2(0, -1))
	self.look_at(Vector2(self.position.x + ROTATION_X, self.position.y + velocity.y))
	

