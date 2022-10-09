extends KinematicBody2D

var velocity = Vector2()

var ACCELERATION = 1000
var SPEED = 200
var JUMP_SPEED = 250
var GRAVITY = 10
var jump_counter = 1

onready var sprite = $Pivot/Sprite
onready var anim_player = $AnimationPlayer
onready var anim_tree = $AnimationTree
onready var playback = anim_tree.get("parameters/playback")
onready var pivot = $Pivot

# Called when the node enters the scene tree for the first time.
func _ready():
	anim_tree.active = true

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func _physics_process(delta):
	velocity = move_and_slide(velocity, Vector2.UP)
	
	var move_input = Input.get_axis("move_player_left", "move_player_right")
	
	# velocity.x = lerp(move_input * SPEED, velocity.x, 0.9)
	velocity.x = move_toward(velocity.x, move_input * SPEED, ACCELERATION * delta)
	velocity.y += GRAVITY
	
	if (is_on_floor() or jump_counter > 0) and  Input.is_action_just_pressed("move_player_up"):
		velocity.y = -JUMP_SPEED
		jump_counter -= 1
		
	elif is_on_floor():
		jump_counter + 1
	
	# Animations
	
	if Input.is_action_pressed("move_player_left") and not Input.is_action_pressed("move_player_right"):
		pivot.scale.x = 1
	if Input.is_action_pressed("move_player_right") and not Input.is_action_pressed("move_player_left"):
		pivot.scale.x = -1
	
	if is_on_floor():
		if abs(velocity.x) > 20:
			playback.travel("run")
		else:
			playback.travel("idle")
	else:	#TODO fix landing visual bug
		if velocity.y < 0:
			playback.travel("jump")
		else:
			playback.travel("fall")
