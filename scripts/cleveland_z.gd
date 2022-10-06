extends Piece

class_name ClevelandZ

# Called when the node enters the scene tree for the first time.
func _ready():
	COLOR = Color(0, 1, 0)
	for cube in CUBES:
		cube.change_color(Color(0, 1, 0))
	set_sombra()

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
