extends Area2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
export var x_quadrant = -1
export var y_quadrant = -1
export var colission = false


# Called when the node enters the scene tree for the first time.
func _ready():
	connect("body_entered",self,"_on_body_entered")
	connect("area_shape_entered",self,"_on_area_shape_entered")

func _on_body_entered(body: Node):
	colission = true
	if body.has_method("check_line"):
		body.check_line()
	pass

func _on_area_shape_entered(area_rid: RID, area: Area2D, area_shape_index: int, local_shape_index: int):
	colission = true
