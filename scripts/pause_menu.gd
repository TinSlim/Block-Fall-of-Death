extends MarginContainer

signal settings_pressed()
onready var resume = $VBoxContainer/Resume
onready var main_menu = $VBoxContainer/MainMenu
onready var exit = $VBoxContainer/Exit
onready var settings = $VBoxContainer/Settings


func _ready():
	resume.connect("pressed",self,"_on_resume_pressed")
	main_menu.connect("pressed",self,"_on_main_menu_pressed")
	exit.connect("pressed",self,"_on_exit_pressed")
	settings.connect("pressed",self,"_on_settings_pressed")
	visible = false
	
func _input(event):
	if event.is_action_pressed("pause"):
		visible = not visible
		get_tree().paused = visible
	
func _on_resume_pressed():
	get_tree().paused = false
	visible = not visible
	
func _on_main_menu_pressed():
	get_tree().change_scene("res://scenes/ui/main_menu.tscn")
	get_tree().paused = false
	
	
func _on_settings_pressed():
	emit_signal("settings_pressed")

func _on_exit_pressed():
	get_tree().quit()
