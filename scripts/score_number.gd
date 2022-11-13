extends MarginContainer

onready var highscore_label = $VBoxContainer/Highscore
var highscore = 0 setget set_highscore

onready var score_label = $VBoxContainer/Score
var score = 0 setget set_score

# Loads the actual highscore from the DB
func _ready():
	set_highscore(DB.data["highscore"])

# Set the new highscore and update the highscore label
func set_highscore(value):
	highscore = value
	highscore_label.text = str(highscore)

# Set the new score and update the score label
func set_score(value):
	score = value
	score_label.text = str(score)

# Updates the highscore in the DB only if the actual score 
# is greater than the actual highscore
func update_db():
	if score > highscore:
		DB.data["highscore"] = score
		DB.save_db()
