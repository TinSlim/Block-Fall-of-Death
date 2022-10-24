extends StaticBody2D

# Declare member variables here. Examples:
# var a = 2
# var b = "text"
export var x_quadrant = -1
export var y_quadrant = -1
export var colission = false
onready var fire = $Fire
onready var LavaClass = preload("res://scripts/lava.gd")

# Called when the node enters the scene tree for the first time.
func _ready():
	connect("body_entered",self,"_on_body_entered")
	connect("area_shape_entered",self,"_on_area_shape_entered")


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func _on_body_entered(body: Node):
	colission = true
	if body.has_method("check_line"):
		body.check_line()
	pass
	#if body.has_method("check_line"):
	#	body.check_line()
		
func _on_area_shape_entered(area_rid: RID, area: Area2D, area_shape_index: int, local_shape_index: int):
	colission = true
	print(area)

func change_color(color):
	var SPRITE = self.find_node("Sprite")
	SPRITE.modulate = color


func _on_Area2D_area_entered(area):
	if (area is LavaClass):
		fire.burn()
	pass # Replace with function body.
