extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

var BLOCK_SIZE = 32
var GRID_HEIGHT = 8
var LAVA_OFFSET = 8
var BloqueLava = preload("res://scenes/lava.tscn")

# Called when the node enters the scene tree for the first time.
func _ready():
	for x in range(-1, 19):
		var actual_lava = BloqueLava.instance()
		actual_lava.position = Vector2((x + 1) * BLOCK_SIZE, BLOCK_SIZE * (GRID_HEIGHT + 2) + LAVA_OFFSET)
		self.add_child(actual_lava)
		
	pass # Replace with function body.

func move_up():
	var actual_children = self.get_children()
	for i in range(self.get_child_count()):
		actual_children[i].position.y -= BLOCK_SIZE
