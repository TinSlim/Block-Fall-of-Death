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

var delta_lava = 0
var lava_rising = 15
var rising_num = 0
var actual_item = null
var item_counter = 0

onready var lava_floor = $LavaFloor

var ricky = preload("res://scenes/pieces/blue_ricky.tscn")

var DOBLE_JUMP = preload("res://scenes/PowerUpJump.tscn")
onready var POWER_UPS = [
	DOBLE_JUMP
	]

var object_dif = 200
var rng = RandomNumberGenerator.new()


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
	
	delta_lava += delta
	if delta_lava > lava_rising and rising_num == 0:
		lava_floor.move_up()
		delta_lava = 0
		rising_num += 1
	elif rising_num > 0 and delta_lava > lava_rising / rising_num:
		delta_lava = 0
		rising_num += 1
		
		## Desplaza Bloques hacia abajo
		for cube in $StaticCubes.get_children():
			cube.position = Vector2(cube.position.x, cube.position.y - 1000)
		$Dunny.position.y += BLOCK_SIZE
		for cube in $StaticCubes.get_children():
			cube.position = Vector2(cube.position.x, cube.position.y + 1000 + BLOCK_SIZE)
		
	
	if playing and (movement_counter%movement_dif == 0):
		
		# si tiene bloque abajo, se queda ahí
		if (actual_object.over_object()):
			playing = false	
			for cube in actual_object.CUBES:
				var new_object = BloqueEstatico.instance()
				new_object.change_color(actual_object.COLOR)
				$StaticCubes.add_child(new_object)
				new_object.position = cube.global_position
			actual_object.queue_free()
		
		else:	
			actual_object.reset_colission()
			actual_object.position.y += BLOCK_SIZE
			if actual_object.check_lava():
				actual_object.queue_free()
				playing = false
			

	
	# Si no juega crea un bloque
	if !playing:
		actual_object = PIECES_ARRAY[index_piece].instance()
		index_piece = index_piece + 1
		if index_piece == 7:
			PIECES_ARRAY.shuffle()
			index_piece = 0
			
		$StaticCubes.add_child(actual_object)
		actual_object.position = Vector2(init_pos.x * BLOCK_SIZE,8)
		playing = true
	
	# Movimiento bloque hacia los lados con Input
	if Input.is_action_just_pressed("move_claw_left") and not Input.is_action_pressed("move_claw_right") and not actual_object.left_object():
		actual_object.reset_colission()
		actual_object.position.x -= BLOCK_SIZE
	if Input.is_action_just_pressed("move_claw_right") and not Input.is_action_pressed("move_claw_left") and not actual_object.right_object():
		actual_object.reset_colission()
		actual_object.position.x += BLOCK_SIZE
	
	# Caída bloque
	movement_counter += 1
	if (actual_item == null or !is_instance_valid(actual_item)):
		
		if (item_counter % object_dif == 0):
			actual_item = POWER_UPS[0].instance()
			actual_item.position = Vector2(rng.randf_range(0,BLOCK_SIZE* 19),0)
			$Powers.add_child(actual_item)
		item_counter += 1
	#print(actual_item)
	#print(movement_counter)
	
func _check_lines():
	pass
