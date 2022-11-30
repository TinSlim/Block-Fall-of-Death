extends Control

var act = 0
var vel = 0
onready var lava = $Node2D

onready var restart = $Restart
onready var menu = $Menu

# Called when the node enters the scene tree for the first time.
func _ready():
	restart.connect("pressed",self,"_on_restart_pressed")
	menu.connect("pressed",self,"_on_menu_pressed")
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if act < 450:
		act = act + vel
		lava.position.y =  lava.position.y + vel
		vel += 0.1
	pass


func _on_restart_pressed():
	get_tree().change_scene("res://scenes/nivelTetris.tscn")
	
func _on_menu_pressed():
	get_tree().change_scene("res://scenes/ui/main_menu.tscn")
	


func _on_settings_pressed():
	pass
