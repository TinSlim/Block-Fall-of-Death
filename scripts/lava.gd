extends Area2D

var lava_floor = null

func _on_body_entered(body: Node):
	if (body.name == "Bunny"):
		if not lava_floor:
			print("Not lava_floor at lava.gd")
			return
		lava_floor.game_over()
		
	body.queue_free()

func _on_Lava_area_entered(area):
	if (area.name == "PowerUpJump"):
		area.queue_free()
