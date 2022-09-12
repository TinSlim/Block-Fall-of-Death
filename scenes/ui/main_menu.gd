extends MarginContainer

onready var play = $VBoxContainer/HBoxContainer/VBoxContainer2/Play
onready var credits = $VBoxContainer/HBoxContainer/VBoxContainer2/Credits
onready var exit = $VBoxContainer/HBoxContainer/VBoxContainer2/Exit
onready var play2 = $VBoxContainer/HBoxContainer/VBoxContainer2/Play2

func _ready():
	play.connect("pressed",self,"_on_play_pressed")
	credits.connect("pressed",self,"_on_credits_pressed")
	exit.connect("pressed",self,"_on_exit_pressed")
	play2.connect("pressed",self,"_on_play2_pressed")

func _on_play_pressed():
	get_tree().change_scene("res://scenes/nivel.tscn")

func _on_play2_pressed():
	get_tree().change_scene("res://scenes/nivelTetris.tscn")
	
func _on_credits_pressed():
	print(".....")
	
func _on_exit_pressed():
	get_tree().quit()
