extends Node2D


var SCENE_BLUE_RICKY = preload("res://scenes/pieces/blue_ricky.tscn").instance()
var SCENE_ORANGE_RICKY = preload("res://scenes/pieces/orange_ricky.tscn").instance()
var SCENE_CLEVELAND_Z = preload("res://scenes/pieces/cleveland_z.tscn").instance()
var SCENE_RHODE_ISLAND_Z = preload("res://scenes/pieces/rhode_island_z.tscn").instance()
var SCENE_HERO = preload("res://scenes/pieces/hero.tscn").instance()
var SCENE_SMASHBOY = preload("res://scenes/pieces/smashboy.tscn").instance()
var SCENE_TEEWEE = preload("res://scenes/pieces/teewee.tscn").instance()
var PIECES_ARRAY = []

var moving_piece = false
var actual_piece
var init_pos

# Called when the node enters the scene tree for the first time.
func _ready():
	PIECES_ARRAY.append(SCENE_BLUE_RICKY)
	PIECES_ARRAY.append(SCENE_ORANGE_RICKY)
	PIECES_ARRAY.append(SCENE_CLEVELAND_Z)
	PIECES_ARRAY.append(SCENE_RHODE_ISLAND_Z)
	PIECES_ARRAY.append(SCENE_HERO)
	PIECES_ARRAY.append(SCENE_SMASHBOY)
	PIECES_ARRAY.append(SCENE_TEEWEE)
	
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var claw = find_node("Claw")
	
	if not moving_piece:
		var piece_idx = randi() % 7
		actual_piece = PIECES_ARRAY[piece_idx]
		add_child(actual_piece)
		moving_piece = true
	
	init_pos = claw.position
	print(init_pos)
	actual_piece.set_position(init_pos)
