extends Area2D

func _on_PowerUpJump_body_entered(body):
	body.jump_counter = 2
	queue_free()
