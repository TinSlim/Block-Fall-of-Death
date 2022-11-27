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
onready var pause_menu = $CanvasLayer/PauseMenu
onready var settings = $CanvasLayer/Settings


# Called when the node enters the scene tree for the first time.
func _ready():
	anim_tree.active = true
	pause_menu.connect("settings_pressed",self, "_on_settings_pressed")
	settings.connect("close_pressed",self,"_on_closed_pressed")

func _physics_process(delta):
	velocity = move_and_slide(velocity, Vector2.UP)
	
	var move_input = Input.get_axis("move_player_left", "move_player_right")
	
	# velocity.x = lerp(move_input * SPEED, velocity.x, 0.9)
	velocity.x = move_toward(velocity.x, move_input * SPEED, ACCELERATION * delta)
	velocity.y += GRAVITY
	
	if (is_on_floor() or jump_counter > 0) and  Input.is_action_just_pressed("move_player_up"):
		velocity.y = -JUMP_SPEED
		jump_counter -= 1
		$Jump.play()
		
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
	else:
		if velocity.y < 0:
			playback.travel("jump")
		else:
			playback.travel("fall")
			
func _on_settings_pressed():
	pause_menu.hide()
	settings.show()
	
func _on_closed_pressed():
	pause_menu.show()
	settings.hide()
