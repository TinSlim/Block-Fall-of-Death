extends Node2D


# Declare member variables here. Examples:
export var x_quadrant = -1
export var y_quadrant = -1
export var our_blocks = []

var colission = false
var colission_drcha = false
var colission_izqu = false
var colission_lava = false
var selfStaticBody

var on_right_wall = false
var on_left_wall = false

var in_suelo = false

onready var fire = $BloqueEstatico/Fire
onready var LavaClass = preload("res://scripts/lava.gd")



# Called when the node enters the scene tree for the first time.
func _ready():
	selfStaticBody = $StaticBody2D
	connect("body_entered",self,"_on_body_entered")
	connect("area_shape_entered",self,"_on_area_shape_entered")


func change_color(color):
	var SPRITE = self.find_node("Sprite")
	SPRITE.modulate = color


func _on_Derecha_body_entered(body):
	if (body.name != "BloqueEstatico"):
		colission_drcha = true
	if (body.name == "Right_Wall"):
		on_right_wall = true
	pass # Replace with function body.

func _on_Derecha_body_exited(body):
	if (body.name == "Right_Wall"):
		on_right_wall = false
	if (body.name != "BloqueEstatico"):
		colission_drcha = false
	pass # Replace with function body.
	
func _on_Suelo_body_entered(body):
	if (body.name != "BloqueEstatico"):
		colission = true
	if (body.name == "Floor"):
		in_suelo = true
	pass # Replace with function body.

func _on_Suelo_body_exited(body):
	if (body.name != "BloqueEstatico"):
		colission = false
	if (body.name == "Floor"):
		in_suelo = false
	pass # Replace with function body.
	
func _on_Izquierda_body_entered(body):
	if (body.name != "BloqueEstatico"):
		colission_izqu = true
	if (body.name == "Left_Wall"):
		on_left_wall = true
	pass # Replace with function body.

func _on_Izquierda_body_exited(body):
	if (body.name == "Left_Wall"):
		on_left_wall = false
	if (body.name != "BloqueEstatico"):
		colission_izqu = false
	pass # Replace with function body.

func _on_Techo_area_entered(area):
	if (area is LavaClass):
		colission_lava = true
	pass # Replace with function body.

func _on_Suelo_area_entered(area):
	if (area is LavaClass):
		fire.burn()
	pass # Replace with function body.









