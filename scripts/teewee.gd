extends Piece

class_name Teewee

# Called when the node enters the scene tree for the first time.
func _ready():
	COLOR = Color(1, 0, 1)
	for cube in CUBES:
		cube.change_color(Color(1, 0, 1))
	set_sombra()

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
