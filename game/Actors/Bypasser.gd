extends KinematicBody2D


var x_speed : float = 250

# -1 for opposite lanes, 1 for same direction lanes
var direction = -1

onready var splat_sound = $SplatSound
onready var sprite = $AnimatedSprite

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	var velocity = Vector2(x_speed * direction, 0)
	
	self.move_and_slide(velocity)

func _on_Hitbox_area_entered(area):
	if area.is_in_group("KillZone"):
		self.queue_free()
	if area.is_in_group("Roadkill"):
		area.get_parent_killed()
		splat_sound.play()
		
	#Avoids cars inside one another
	if area.is_in_group("Bypasser"):
		self.queue_free()
