extends KinematicBody2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
export var x_quadrant = -1
export var y_quadrant = -1

# Called when the node enters the scene tree for the first time.
func _ready():
	connect("body_entered",self,"_on_body_entered")
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func _on_body_entered(body: Node):
	if body.has_method("check_line"):
		body.check_line()
	print("parentx")
	pass
	#if body.has_method("check_line"):
	#	body.check_line()
		
