extends Node2D

class_name Piece

var delta_acc = 0
onready var PIVOT = self.find_node("Pivot")
onready var CUBES = self.find_node("Cubes").get_children()
onready var SOMBRA = self.find_node("Sombra")
onready var SOMBRAS = []
export var colission = false
export var COLOR = Color(0, 0, 0)
var rotate = true

var on_right_wall = false
var on_left_wall = false

var Bloque = preload("res://scenes/figura.tscn")

func rotate_piece():
	if (rotation_not_posible()):
		return
	PIVOT.rotation_degrees = PIVOT.rotation_degrees + 90
	for cube in CUBES:
		cube.rotation_degrees = cube.rotation_degrees - 90
	reset_colission()

func clear_right_wall ():
	for cube in CUBES:
		cube.on_right_wall = false
		
func clear_left_wall ():
	for cube in CUBES:
		cube.on_left_wall = false
		
func over_object():
	for cube in CUBES:
		if cube.colission:
			return true
	return false

func right_object():
	for cube in CUBES:
		if cube.colission_drcha or cube.on_right_wall:
			return true
	return false
	
func left_object():
	for cube in CUBES:
		if cube.colission_izqu  or cube.on_left_wall:
			return true
	return false

func rotation_not_posible ():
	for sombra in SOMBRAS:
		if sombra.colission:
			return true
	return false
	
func reset_colission():
	reset_sombra()
	for cube in CUBES:
		if not cube.in_suelo:
			cube.colission = false
		cube.colission_drcha = false
		cube.colission_izqu = false
	
	
func reset_sombra():
	for sombra in SOMBRAS:
		sombra.colission = false
		

func set_sombra():
	for cube in CUBES:
		var new_sombra = Bloque.instance()
		new_sombra.position = Vector2(-cube.position.y,cube.position.x)
		SOMBRA.add_child(new_sombra)
	SOMBRAS = SOMBRA.get_children()

func check_lava():
	for cube in CUBES:
		if cube.colission_lava:
			return true
	return false
		
func disable_rotation():
	self.rotate = false
		
# Called when the node enters the scene tree for the first time.
func _physics_process(delta):
	delta_acc = delta_acc + delta
	if self.rotate and delta_acc > 0.5 and Input.is_action_pressed("rotate"):
		self.rotate_piece()
		delta_acc = 0
	


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
