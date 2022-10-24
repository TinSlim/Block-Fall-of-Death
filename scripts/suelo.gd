extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

var BloqueEstatico = preload("res://scenes/figuraStatic.tscn")
var BloqueLava = preload("res://scenes/lava.tscn")

# Called when the node enters the scene tree for the first time.
func _ready():
	for x in range(18):
		var actual_object = BloqueEstatico.instance()
		actual_object.position = Vector2(x * 32 + 32, 10)
		var actual_lava = BloqueLava.instance()
		actual_lava.position = Vector2(x * 32 + 32, 10 + 32)
		
	pass # Replace with function body.
