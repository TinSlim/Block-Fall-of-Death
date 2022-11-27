extends Node2D

onready var piece_container = $StatusContainer/VBoxContainer/PieceContainer
onready var lava_count_number_label = $StatusContainer/VBoxContainer/LavaCountNumber

var lava_count_number setget _lava_count_number_set

# Called when the node enters the scene tree for the first time.
func _ready():
	update_next_piece()
	_lava_count_number_set(15)

func update_next_piece():
	# Delete last piece
	for child in piece_container.get_children():
		child.queue_free()
	# Create new piece and add it to the dashboard
	var next_piece : Node2D = PiecesArray.get_piece().instance()
	next_piece.disable_rotation()
	piece_container.add_child(next_piece)
	next_piece.position = PiecesArray.get_adjust() + Vector2(65, 186)

func _lava_count_number_set(value):
	lava_count_number = value
	lava_count_number_label.text = str(lava_count_number)
