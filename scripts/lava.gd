extends Area2D

var lava_floor = null

func _on_body_entered(body: Node):
	if body is Bunny:
		if not lava_floor:
			print("Not lava_floor at lava.gd")
			return
		lava_floor.game_over()
	#Right_Wall or body is Left_Wall:
	#	return
	if body.name == 'Right_Wall' or body.name == 'Left_Wall':
		return
	body.queue_free()

func _on_Lava_area_entered(area):
	if area is JumpPU:
		area.queue_free()
