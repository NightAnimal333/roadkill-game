extends Area2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

signal hit_by_car

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.
	
func get_parent_killed():
	emit_signal("hit_by_car")


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
