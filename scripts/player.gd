extends CharacterBody2D

# player animated sprite node
@onready var player_anim = $AnimatedSprite2D

# global variables 
const SPEED = 100.0
# current player direction, default to front/idle
var current_dir = "front"
var current_anim = "idle_front"

func _ready():
	player_anim.play("idle_front")

func _physics_process(delta):
	player_movement(delta)
	
func player_movement(delta):
	velocity.x = 0
	velocity.y = 0
	
	#movement control, is aciton pressed for continues press, is event for on time press 
	if Input.is_action_pressed("ui_right"):
		player_anim.flip_h = false
		current_dir = "side"
		velocity.x = SPEED
		
	elif Input.is_action_pressed("ui_left"):
		player_anim.flip_h = true
		current_dir = "side"
		velocity.x = -SPEED
		
	elif Input.is_action_pressed("ui_down"):
		current_dir = "front"
		velocity.y = SPEED
		
	elif Input.is_action_pressed("ui_up"):
		current_dir = "back"
		velocity.y = -SPEED
	
	# Set animation based on movement - keeps last direction
	if velocity.length() > 0:
		current_anim = "walk_" + current_dir
	else:
		current_anim = "idle_" + current_dir
	
	player_anim.play(current_anim)
	move_and_slide()
