extends Node2D

onready var highscore_number_label = $ScoreNode/Scores/VBoxContainer/HighscoreNumber
onready var score_number_label = $ScoreNode/Scores/VBoxContainer/ScoreNumber

var highscore_number setget _highscore_number_set
var score_number setget _score_number_set


# Called when the node enters the scene tree for the first time.
func _ready():
	_highscore_number_set(DB.data["highscore"])
	_score_number_set(0)

# Set the new highscore and update the highscore label
func _highscore_number_set(value):
	highscore_number = value
	highscore_number_label.text = str(highscore_number)

# Set the new score and update the score label
func _score_number_set(value):
	score_number = value
	score_number_label.text = str(score_number)

# Updates the highscore in the DB only if the actual score 
# is greater than the actual highscore
func update_db():
	if score_number > highscore_number:
		DB.data["highscore"] = score_number
		DB.save_db()
