extends Node2D


var grid_size = Vector2(16,16)
var grid = []
var playing = false
var actual_object = null
var movement_counter = 0
var movement_dif = 30
var init_pos = Vector2(8,0)
var BLOCK_SIZE = PiecesArray.BLOCK_SIZE

var Bloque = preload("res://scenes/figura.tscn")
var BloqueEstatico = preload("res://scenes/figuraStatic.tscn")

var going_down = 0

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

# Score variables
onready var score_number = $"Camera2D/Static/ScoreNumber"
var acc_time = 0
var score_per_second = 10

onready var score_board = $Camera2D/Static/ScoreBoard
onready var status_board = $Camera2D/Static/StatusBoard


# grid [arriba parte-fila] [izquierda parte-columna]
# Called when the node enters the scene tree for the first time.
func _ready():
	for x in range(grid_size.x):
		grid.append([])
		for y in range(grid_size.y):
			grid[x].append(0)
	lava_floor.MAIN_SCENE = self
	# move dashboards
	score_board.position = Vector2(-100,0) # TODO adjust this position
	status_board.position = Vector2(500,0) # TODO adjust this position

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	
	# Scoring process
	acc_time += delta
	if acc_time >= 1:
		acc_time -= 1
		score_number.score += score_per_second
	
	delta_lava += delta
	if delta_lava > lava_rising and rising_num == 0:
		lava_floor.move_up()
		delta_lava = 0
		rising_num += 1
	elif rising_num > 0 and delta_lava > lava_rising / rising_num:
		delta_lava = 0
		rising_num += 1
		
		lava_floor.move_up()
		$Camera2D.position.y-= BLOCK_SIZE
		going_down += 1
		## Desplaza Bloques hacia abajo
		##for cube in $StaticCubes.get_children():
		##	cube.position = Vector2(cube.position.x, cube.position.y - 1000)
		##$Dunny.position.y += BLOCK_SIZE
		##for cube in $StaticCubes.get_children():
		##	cube.position = Vector2(cube.position.x, cube.position.y + 1000 + BLOCK_SIZE)
		
	
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
		actual_object = PiecesArray.get_piece().instance()
		PiecesArray.update_index()
		status_board.update_piece()
			
		$StaticCubes.add_child(actual_object)
		actual_object.position = Vector2(init_pos.x * BLOCK_SIZE,8 - (going_down * BLOCK_SIZE))
		playing = true
	
	#######
	## Movimiento de bloques/garra
	#######
	# Movimiento bloque hacia los lados con Input
	if Input.is_action_just_pressed("move_claw_left") and not Input.is_action_pressed("move_claw_right") and not actual_object.left_object():
		actual_object.reset_colission()
		actual_object.position.x -= BLOCK_SIZE
	
	if Input.is_action_just_pressed("move_claw_right") and not Input.is_action_pressed("move_claw_left") and not actual_object.right_object():
		actual_object.reset_colission()
		actual_object.position.x += BLOCK_SIZE
	
	if Input.is_action_pressed("move_claw_down"):
		movement_dif = 15
	elif Input.is_action_pressed("move_claw_up"):
		movement_dif = 1
	else:
		movement_dif = 30

		
	
	# Caída bloque
	movement_counter += 1
	if (actual_item == null or !is_instance_valid(actual_item)):
		if (item_counter % object_dif == 0):
			actual_item = POWER_UPS[0].instance()
			actual_item.position = Vector2(rng.randf_range(0,BLOCK_SIZE* 19),0 - (going_down * BLOCK_SIZE))
			$Powers.add_child(actual_item)
		item_counter += 1

# Function triggered if Bunny touch the lava
# It updates the highscore and show the game over animation
func game_over():
	score_number.update_db()
	# Gamer Over Animation
	get_tree().change_scene("res://scenes/ui/main_menu.tscn")
