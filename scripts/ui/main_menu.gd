extends MarginContainer

onready var play = $Menu/VBoxContainer/HBoxContainer/VBoxContainer2/Play
onready var credits = $Menu/VBoxContainer/HBoxContainer/VBoxContainer2/Credits
onready var exit = $Menu/VBoxContainer/HBoxContainer/VBoxContainer2/Exit

func _ready():
	play.connect("pressed",self,"_on_play_pressed")
	credits.connect("pressed",self,"_on_credits_pressed")
	exit.connect("pressed",self,"_on_exit_pressed")
	
	play.grab_focus()

func _on_play_pressed():
	get_tree().change_scene("res://scenes/nivelTetris.tscn")
	
func _on_credits_pressed():
	get_tree().change_scene("res://scenes/ui/credits.tscn")
	
func _on_exit_pressed():
	get_tree().quit()

func _on_settings_pressed():
	pass
