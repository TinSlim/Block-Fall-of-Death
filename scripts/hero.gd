extends Piece

class_name Hero

# Called when the node enters the scene tree for the first time.
func _ready():
	for cube in CUBES:
		cube.change_color(Color(0, 1, 1))


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
