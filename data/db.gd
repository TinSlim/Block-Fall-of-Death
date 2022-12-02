extends Node

var data = {}

var is_new_highscore = false setget ,get_is_new_highscore
var actual_score = 0 setget ,get_actual_score

func _ready():
	load_db()
	
func load_db():
	var file = File.new()
	file.open("res://data/db.json", File.READ)
	var content = file.get_as_text()
	file.close()
	data = JSON.parse(content).result

func save_db():
	var file = File.new()
	file.open("res://data/db.json", File.WRITE)
	file.store_line(to_json(data))
	file.close()

func get_is_new_highscore():
	var tmp = is_new_highscore
	is_new_highscore = false
	return tmp

func get_actual_score():
	var tmp = actual_score
	actual_score = 0
	return tmp
	
