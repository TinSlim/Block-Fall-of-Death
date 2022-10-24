extends Node2D

onready var sprite = $Sprite


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.



func burn():
	sprite.visible = true
