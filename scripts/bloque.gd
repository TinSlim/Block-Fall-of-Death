extends Node2D


# Declare member variables here. Examples:
export var x_quadrant = -1
export var y_quadrant = -1
export var our_blocks = []

var colission = false
var colission_drcha = false
var colission_izqu = false
var selfStaticBody



# Called when the node enters the scene tree for the first time.
func _ready():
	selfStaticBody = $StaticBody2D
	connect("body_entered",self,"_on_body_entered")
	connect("area_shape_entered",self,"_on_area_shape_entered")


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

#func _on_body_entered(body: Node):
#	colission = true
#	if body.has_method("check_line"):
#		body.check_line()
#	print(body)
#	pass
	#if body.has_method("check_line"):
	#	body.check_line()
		
#func _on_area_shape_entered(area_rid: RID, area: Area2D, area_shape_index: int, local_shape_index: int):
#	colission = true
#	print(area)

func change_color(color):
	var SPRITE = self.find_node("Sprite")
	SPRITE.modulate = color



func _on_Derecha_body_entered(body):
	if (body.name != "BloqueEstatico"):
		colission_drcha = true
	pass # Replace with function body.


func _on_Suelo_body_entered(body):
	if (body.name != "BloqueEstatico"):
		colission = true
	pass # Replace with function body.


func _on_Izquierda_body_entered(body):
	if (body.name != "BloqueEstatico"):
		colission_izqu = true
	pass # Replace with function body.
