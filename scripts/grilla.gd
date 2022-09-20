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
#export(PacketScene) var Bloque

# grid [arriba parte-fila] [izquierda parte-columna]
# Called when the node enters the scene tree for the first time.
func _ready():
	for x in range(grid_size.x):
		grid.append([])
		for y in range(grid_size.y):
			grid[x].append(0)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	
	if playing and (movement_counter%movement_dif == 0):
		actual_object.position.y += BLOCK_SIZE
		if (true):
			pass
		pass
	
	if playing and actual_object.colission:
		playing = false	
		var new_object = BloqueEstatico.instance()
		$Node2D.add_child(new_object)
		print("llegue aca")
		new_object.position = actual_object.position
		actual_object.queue_free()
	
	# Si no juega crea un bloque
	if !playing:
		actual_object = Bloque.instance()
		$Node2D.add_child(actual_object)
		actual_object.position = init_pos * BLOCK_SIZE
		playing = true
		pass
	
	# Movimiento bloque
	if Input.is_action_just_pressed("move_claw_left") and not Input.is_action_pressed("move_claw_right"):
		actual_object.position.x -= BLOCK_SIZE
	if Input.is_action_just_pressed("move_claw_right") and not Input.is_action_pressed("move_claw_left"):
		actual_object.position.x += BLOCK_SIZE
	
	# Caída bloque
	movement_counter += 1

func _check_lines():
	pass
