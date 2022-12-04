extends Area2D

export var x_quadrant = -1
export var y_quadrant = -1

export var colission = false
export var colission_wall_der = false
export var colission_wall_izq = false

# Called when the node enters the scene tree for the first time.
func _ready():
	connect("body_entered",self,"_on_body_entered")
	connect("area_shape_entered",self,"_on_area_shape_entered")

func _on_body_entered(body: Node):
	if (body.name == "Right_Wall"):
		colission_wall_der = true
	if (body.name == "Left_Wall"):
		colission_wall_izq = true
	if (body.name != "BloqueEstatico"):
		colission = true
	pass # Replace with function body.



func _on_Bloque_body_exited(body):
	if (body.name == "Right_Wall"):
		colission_wall_der = false
	if (body.name == "Left_Wall"):
		colission_wall_izq = false
	if (body.name != "BloqueEstatico"):
		colission = false
	pass # Replace with function body.
