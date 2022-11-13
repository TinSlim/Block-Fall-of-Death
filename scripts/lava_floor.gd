extends Node2D

var BLOCK_SIZE = 32
var GRID_HEIGHT = 8
var LAVA_OFFSET = 8
var BloqueLava = preload("res://scenes/lava.tscn")
var MAIN_SCENE = null

# Called when the node enters the scene tree for the first time.
func _ready():
	for x in range(-1, 19):
		var actual_lava = BloqueLava.instance()
		actual_lava.lava_floor = self
		actual_lava.position = Vector2((x + 1) * BLOCK_SIZE, BLOCK_SIZE * (GRID_HEIGHT + 2) + LAVA_OFFSET)
		self.add_child(actual_lava)

func move_up():
	var actual_children = self.get_children()
	for i in range(self.get_child_count()):
		actual_children[i].position.y -= BLOCK_SIZE

# Function to call the game over method of the main scene
func game_over():
	if not MAIN_SCENE:
		print("Not MAIN_SCENE at lava_floor.gd")
	MAIN_SCENE.game_over()
