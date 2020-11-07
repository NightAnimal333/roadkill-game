extends KinematicBody2D

var speed = 200
var velocity = Vector2()

func _physics_process(delta):
	if Input.is_action_pressed("ui_right"):
		velocity.x = speed
	else:
		velocity.x = 0
	
	velocity = move_and_slide(velocity)


func _on_Area2D_body_entered(body):
	if body.is_in_group("Animal"):
		body.queue_free()
