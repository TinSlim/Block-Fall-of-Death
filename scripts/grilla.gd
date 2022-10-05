extends Node2D


var grid_size = Vector2(16,16)
var grid = []
var playing = false
var actual_object = null
var movement_counter = 0
var movement_dif = 30
var init_pos = Vector2(8,0)
var BLOCK_SIZE = 32

var Bloque = preload("res://scenes/figura.tscn")
var BloqueEstatico = preload("res://scenes/figuraStatic.tscn")

var SCENE_BLUE_RICKY = preload("res://scenes/pieces/blue_ricky.tscn")
var SCENE_ORANGE_RICKY = preload("res://scenes/pieces/orange_ricky.tscn")
var SCENE_CLEVELAND_Z = preload("res://scenes/pieces/cleveland_z.tscn")
var SCENE_RHODE_ISLAND_Z = preload("res://scenes/pieces/rhode_island_z.tscn")
var SCENE_HERO = preload("res://scenes/pieces/hero.tscn")
var SCENE_SMASHBOY = preload("res://scenes/pieces/smashboy.tscn")
var SCENE_TEEWEE = preload("res://scenes/pieces/teewee.tscn")

onready var PIECES_ARRAY = [
	SCENE_BLUE_RICKY,
	SCENE_ORANGE_RICKY,
	SCENE_CLEVELAND_Z,
	SCENE_RHODE_ISLAND_Z,
	SCENE_HERO,
	SCENE_SMASHBOY,
	SCENE_TEEWEE
	]
var PIECES_COUNTER = 0

var index_piece = 0

var ricky = preload("res://scenes/pieces/blue_ricky.tscn")
#export(PacketScene) var Bloque

# grid [arriba parte-fila] [izquierda parte-columna]
# Called when the node enters the scene tree for the first time.
func _ready():
	PIECES_ARRAY.shuffle()
	for x in range(grid_size.x):
		grid.append([])
		for y in range(grid_size.y):
			grid[x].append(0)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	
	
	# tiene que bajar
	
	if playing and (movement_counter%movement_dif == 0):
		
		# si tiene bloque abajo, se queda ahí
		if (actual_object.over_object()):
			playing = false	
			for cube in actual_object.CUBES:
				var new_object = BloqueEstatico.instance()
				new_object.change_color(actual_object.COLOR)
				$Node2D.add_child(new_object)
				new_object.position = cube.global_position
			actual_object.queue_free()
		
		else:	
			actual_object.reset_colission()
			actual_object.position.y += BLOCK_SIZE
			

	
	# Si no juega crea un bloque
	if !playing:
		actual_object = PIECES_ARRAY[index_piece].instance()
		index_piece = index_piece + 1
		if index_piece == 7:
			PIECES_ARRAY.shuffle()
			index_piece = 0
			
		$Node2D.add_child(actual_object)
		actual_object.position = Vector2(init_pos.x * BLOCK_SIZE,8)
		playing = true
	
	# Movimiento bloque
	if Input.is_action_just_pressed("move_claw_left") and not Input.is_action_pressed("move_claw_right") and not actual_object.left_object():
		actual_object.reset_colission()
		actual_object.position.x -= BLOCK_SIZE
	if Input.is_action_just_pressed("move_claw_right") and not Input.is_action_pressed("move_claw_left") and not actual_object.right_object():
		actual_object.reset_colission()
		actual_object.position.x += BLOCK_SIZE
	
	# Caída bloque
	movement_counter += 1

func _check_lines():
	pass
