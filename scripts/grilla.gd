extends Node2D

# Constants
var BLOCK_SIZE = PiecesArray.BLOCK_SIZE
var playing = false
var actual_piece = null
var movement_counter = 0
var movement_dif = 30
var init_piece_pos = Vector2(140 + 4 + 8*BLOCK_SIZE - (BLOCK_SIZE/2), 2 + (BLOCK_SIZE/2))
var BloqueEstatico = preload("res://scenes/figuraStatic.tscn")

# Bunny
onready var bunny = $Bunny

# Lava rising variables
var lava_up = false
var total_lava_countdown = 15
var lava_countdown = total_lava_countdown
var min_lava_countdown = 1.5

# Lava Floor variables
onready var lava_floor = $LavaFloor
var going_down = 0

# Power up variables
var DOBLE_JUMP = preload("res://scenes/PowerUpJump.tscn")
onready var POWER_UPS = [
	DOBLE_JUMP
	]

# Character power up variables 
var actual_item = null
var item_counter = 0

# Score variables
var acc_time = 0
var score_per_second = 10

# Dashboard variables
onready var score_board = $Camera2D/Static/ScoreBoard
onready var status_board = $Camera2D/Static/StatusBoard

var object_dif = 200
var rng = RandomNumberGenerator.new()

# Called when the node enters the scene tree for the first time.
func _ready():
	# Locate Bunny
	# X: SCORE_DASHBOARD + OFFSET + 14 BLOCK
	# Y : OFFSET + 12 BLOCK - BUNNY SIZE / 2 - BUNNY OFFSET
	bunny.position = Vector2(140 + 4 + 14*BLOCK_SIZE, 2 + 13*BLOCK_SIZE - (BLOCK_SIZE/2)  - 2)
	# Init lava floor
	lava_floor.MAIN_SCENE = self
	# Move dashboards
	score_board.position = Vector2(0,0) # TODO adjust this position
	status_board.position = Vector2(660,0) # TODO adjust this position

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	
	# Scoring process
	acc_time += delta
	if acc_time >= 1:
		acc_time -= 1
		score_board.score_number += score_per_second
	
	# Update lava countdown
	lava_countdown -= delta
	if lava_countdown <= 0:
		# Move lava up
		lava_floor.move_up()
		if lava_up:
			$Camera2D.position.y -= BLOCK_SIZE
			going_down += 1
		# Update countdown
		lava_up = true
		total_lava_countdown -= 2
		# Force minimum lava countdown
		if total_lava_countdown < min_lava_countdown:
			lava_countdown = min_lava_countdown
		else:
			lava_countdown = total_lava_countdown
	status_board.update_lava_count(stepify(lava_countdown,0.1))

	if playing and (movement_counter%movement_dif == 0):
		
		# si tiene bloque abajo, se queda ahí
		if (actual_piece.over_object()):
			if actual_piece.position == Vector2(init_piece_pos.x, init_piece_pos.y - (going_down * BLOCK_SIZE)):
				game_over()
			
			playing = false	
			for cube in actual_piece.CUBES:
				var new_object = BloqueEstatico.instance()
				new_object.change_color(actual_piece.COLOR)
				$StaticCubes.add_child(new_object)
				new_object.position = cube.global_position
			actual_piece.queue_free()
		
		else:	
			actual_piece.reset_colission()
			actual_piece.position.y += BLOCK_SIZE
			if actual_piece.check_lava():
				actual_piece.queue_free()
				playing = false
			

	
	# Si no juega crea un bloque
	if !playing:
		actual_piece = PiecesArray.get_piece().instance()
		PiecesArray.update_index()
		status_board.update_piece()
			
		$StaticCubes.add_child(actual_piece)
		actual_piece.position = Vector2(init_piece_pos.x, init_piece_pos.y - (going_down * BLOCK_SIZE))
		playing = true
	
	#######
	## Movimiento de bloques/garra
	#######
	# Movimiento bloque hacia los lados con Input
	if Input.is_action_just_pressed("move_piece_left") and not Input.is_action_pressed("move_piece_right") and not actual_piece.left_object():
		actual_piece.reset_colission()
		actual_piece.clear_right_wall()
		actual_piece.position.x -= BLOCK_SIZE
	
	if Input.is_action_just_pressed("move_piece_right") and not Input.is_action_pressed("move_piece_left") and not actual_piece.right_object():
		actual_piece.reset_colission()
		actual_piece.clear_left_wall()
		actual_piece.position.x += BLOCK_SIZE
	
	if Input.is_action_pressed("move_piece_down"):
		movement_dif = 7
	else:
		movement_dif = 30

		
	
	# Caída bloque
	movement_counter += 1
	if (actual_item == null or !is_instance_valid(actual_item)):
		if (item_counter % object_dif == 0):
			actual_item = POWER_UPS[0].instance()
			actual_item.position = Vector2(init_piece_pos.x + rng.randi_range(-7,8) * BLOCK_SIZE, init_piece_pos.y - (going_down * BLOCK_SIZE))
			$Powers.add_child(actual_item)
		item_counter += 1

# Function triggered if Bunny touch the lava
# It updates the highscore and show the game over animation
func game_over():
	score_board.update_db()
	get_tree().change_scene("res://scenes/endgame.tscn")
