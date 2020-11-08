extends KinematicBody2D

signal player_lost(cause)

var SPEED_STEP_Y : float = 200
var SPEED_STEP_X : float = 100
var BRAKE_STEP : float = 0.99

#The maximum value for Y-axis velocity
var MAX_SPEED_Y : float = 200
var MAX_SPEED_X : float = 700

#The bigger this number - the less the car rotates when you change the y velocity
var ROTATION_X : float = 1000

var velocity : Vector2 

#Only for GUI purposes
var calculated_speed : float = 0
var previous_position : Vector2
var MULTIPLIER = 0.1

var in_mud : bool = 0

var traveled : float = 0
var time_braking : float = 0

onready var splat_sound = $SplatSound

func _ready():
	self.previous_position = self.position
	velocity.x = 100
	velocity.y = 0

func _process(delta):
	
	traveled += (floor(self.position.x) - floor(self.previous_position.x)) * MULTIPLIER
	if delta != 0:
		calculated_speed = floor(((self.position.x - self.previous_position.x) / delta)) * MULTIPLIER
	
	self.previous_position = self.position
	
	if Input.is_action_pressed("move_brake"):
		if velocity.x > 100:
			velocity *= BRAKE_STEP
		else:
			velocity.x = 0 
			velocity.y = 0
		time_braking += delta
			
	else:
		if !in_mud:
			if velocity.x < MAX_SPEED_X:
				velocity.x += SPEED_STEP_X * delta
		else:
			if self.velocity.x > MAX_SPEED_X && velocity.x > 0:
				self.velocity.x *= BRAKE_STEP
		
			if self.velocity.x > MAX_SPEED_Y && velocity.y > 0:
				self.velocity.x -= SPEED_STEP_Y * delta
		
		if Input.is_action_pressed("move_up"):
			if velocity.y > -MAX_SPEED_Y:
				velocity.y -= SPEED_STEP_Y * delta
		#		self.rotate(Vector2(self.position.x + 1, velocity.y).angle())		
				
		if Input.is_action_pressed("move_down"):
			if velocity.y < MAX_SPEED_Y:
				velocity.y += SPEED_STEP_Y * delta
		#		self.rotate(Vector2(self.position.x + 1, velocity.y).angle() * -1)
		
	
	
			
func _physics_process(_delta):
	move_and_slide(Vector2(velocity.x, velocity.y), Vector2(0, -1))
	if !Input.is_action_pressed("move_brake"):
		self.look_at(Vector2(self.position.x + ROTATION_X, self.position.y + velocity.y))
	

func slow_down():
	self.MAX_SPEED_X = 100
	self.MAX_SPEED_Y = 10
	
	self.in_mud = true
	
func speed_up():
	self.MAX_SPEED_X = 700
	self.MAX_SPEED_Y = 200
	
	self.in_mud = false


func _on_Hitbox_area_entered(area):
	if area.is_in_group("SlowZone"):
		self.slow_down()
	elif area.is_in_group("Trees"):
		emit_signal("player_lost", "tree_hit")
		self.queue_free()
	elif area.is_in_group("Bypasser"):
		emit_signal("player_lost", "bypasser_crashed")
		self.queue_free()
	elif area.is_in_group("Roadkill"):
		emit_signal("player_lost", "roadkill_killed")
		self.queue_free()


func _on_Hitbox_area_exited(area):
	if area.is_in_group("SlowZone"):
		self.speed_up()
