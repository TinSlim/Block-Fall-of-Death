extends Area2D

class_name JumpPU

func _physics_process(delta):
	position.y = position.y  + 1
	
func _on_PowerUpJump_body_entered(body):
	if (body.name == "Bunny"):
		body.jump_counter = 2
		$Pop.play()
		queue_free()
