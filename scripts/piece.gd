extends Node2D

class_name Piece

# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var delta_acc = 0
onready var PIVOT = self.find_node("Pivot")
onready var CUBES = PIVOT.get_children()

func rotate_piece():
	PIVOT.rotation_degrees = PIVOT.rotation_degrees + 90


# Called when the node enters the scene tree for the first time.
func _physics_process(delta):
	delta_acc = delta_acc + delta
	if delta_acc > 0.5 and Input.is_action_pressed("rotate"):
		self.rotate_piece()
		delta_acc = 0


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
