extends Area2D

export var x_quadrant = -1
export var y_quadrant = -1
export var colission = false


# Called when the node enters the scene tree for the first time.
func _ready():
	connect("body_entered",self,"_on_body_entered")
	connect("area_shape_entered",self,"_on_area_shape_entered")

func _on_body_entered(body: Node):
	if (body.name != "BloqueEstatico"):
		colission = true
	pass # Replace with function body.

