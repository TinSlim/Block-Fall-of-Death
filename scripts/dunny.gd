extends KinematicBody2D

var velocity = Vector2()

var ACCELERATION = 1000
var SPEED = 200
var JUMP_SPEED = 200
var GRAVITY = 10


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func _physics_process(delta):
	velocity = move_and_slide(velocity, Vector2.UP)
	
	var move_input = Input.get_axis("move_player_left", "move_player_right")
	
	# velocity.x = lerp(move_input * SPEED, velocity.x, 0.9)
	velocity.x = move_toward(velocity.x, move_input * SPEED, ACCELERATION * delta)
	velocity.y += GRAVITY
	
	if is_on_floor() and  Input.is_action_just_pressed("move_player_up"):
		velocity.y = -JUMP_SPEED
	
	
