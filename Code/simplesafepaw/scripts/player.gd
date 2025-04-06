extends CharacterBody2D


var stepping:bool = false
var stepping_dis:float= 0
var start_pos:Vector2
var direction
const SPEED = 200.0
const JUMP_VELOCITY = -300.0
var emit_signal_walk = true
@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D
signal walk_completed

func  _ready() -> void:
	pass

func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta

	# Get the input direction and handle the movement/deceleration.
	# TODO As good practice, you should replace UI actions with custom gameplay actions.
	
	if stepping == true and abs(position.x - start_pos.x) >= abs(stepping_dis):# Condition to stop walking 
		stepping = false
		print("emit_signal_walk", emit_signal_walk)
		if emit_signal_walk == true:
			emit_signal("walk_completed")
	if stepping:
		direction = 1
	else:
		direction = Input.get_axis("ui_left", "ui_right")
	if direction >= 0:
		animated_sprite_2d.flip_h = false
	elif direction < 0:
		animated_sprite_2d.flip_h = true
		
	if direction:
		animated_sprite_2d.play("walk")
		velocity.x = direction * SPEED
	else:
		animated_sprite_2d.play("ideal")
		velocity.x = move_toward(velocity.x, 0, SPEED)
		
	move_and_slide()

func walk_toward_bruno(distance_btw_raylie_and_bruno):
	# Set variables
	stepping = true
	emit_signal_walk = true
	#print("Current postion ryalie",position)
	start_pos = position
	if States.player_state == "PET":
		#print("pet with")
		stepping_dis = max(0, distance_btw_raylie_and_bruno - 150)
	elif States.player_state == "PET_WITHOUT_PERMISSION":
		#print("Pet without")
		print(distance_btw_raylie_and_bruno)
		stepping_dis = distance_btw_raylie_and_bruno/2
		#print("After stepping ", stepping_dis)

func walk_a_distance(distance):
		# Set variables
	stepping = true
	#print("Current postion ryalie",position)
	start_pos = position
	stepping_dis = distance
	emit_signal_walk = false
