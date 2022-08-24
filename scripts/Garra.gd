extends KinematicBody2D


# Declare member variables here. Examples:
var velocity = Vector2()
var BLOCK_SIZE = 90
var LEFT_LIMIT = 0
var RIGHT_LIMIT = BLOCK_SIZE * 10


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	"""velocity = move_and_slide(velocity, Vector2.UP)
	print(Input.get_axis("move_claw_left", "move_claw_right"))
	var move_input = Input.get_axis("move_claw_left", "move_claw_right")
	velocity.x = move_toward(velocity.x, move_input * SPEED, ACCELERATION * delta)
	#if Input.is_action_pressed("move_claw_right") and not Input.is_action_pressed("move_left"):
	#	pivot.scale.x = 1
	#pass"""
	
	if Input.is_action_just_pressed("move_claw_left") and not Input.is_action_pressed("move_claw_right") and position.x > LEFT_LIMIT:
		position.x -= BLOCK_SIZE
	if Input.is_action_just_pressed("move_claw_right") and not Input.is_action_pressed("move_claw_left") and position.x < RIGHT_LIMIT:
		position.x += BLOCK_SIZE
	
