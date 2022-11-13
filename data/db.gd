extends Node

var data = {}

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
