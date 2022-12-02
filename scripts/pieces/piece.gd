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
var rotation_delta = 0.3

var on_right_wall = false
var on_left_wall = false

var Bloque = preload("res://scenes/figura.tscn")

func rotate_piece(to_right):
	if (rotation_not_posible()):
		return
	var rot_angle = 90
	###
	if not to_right:
		rot_angle = -90
	###
	PIVOT.rotation_degrees = PIVOT.rotation_degrees + rot_angle
	for cube in CUBES:
		cube.rotation_degrees = cube.rotation_degrees - rot_angle
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
	if self.rotate and delta_acc > rotation_delta and Input.is_action_pressed("rotate"):
		self.rotate_piece(true)
		delta_acc = 0
	var rotate_input = Vector2(Input.is_action_pressed("rotate_l"), Input.is_action_pressed("rotate_r"))
	if self.rotate and delta_acc > rotation_delta and (rotate_input.x or rotate_input.y):
		self.rotate_piece(rotate_input.y)
		delta_acc = 0
	


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
