extends Node2D

@onready var raylie: CharacterBody2D = $Raylie
@onready var bruno: CharacterBody2D = $Bruno
@onready var ray_to_bruno: RayCast2D = $Raylie/RayToBruno
@onready var coin_label: Node2D = $Raylie/Camera2D/CoinLabel
@onready var ch_1_main: Node2D = $Raylie/Ch1Main
@onready var ch_1_pet_without_permission: Node2D = $Raylie/Ch1PetWithoutPermission
@onready var ch_1_pet_with_prmission: Node2D = $Raylie/Ch1PetWithPrmission
@onready var ch_1_step_2: Node2D = $Raylie/Ch1Step2
@onready var ch_1_touch_head: Node2D = $Raylie/Ch1TouchHead
@onready var ch_1_smell_fist: Node2D = $Raylie/Ch1SmellFist
@onready var ch_1_step_3: Node2D = $Raylie/Ch1Step3
@onready var ch_1_pet_over_head: Node2D = $Raylie/Ch1PetOverHead
@onready var ch_1_pet_under_chin: Node2D = $Raylie/Ch1PetUnderChin
@onready var dialogue_initaited = false
@onready var dialogue = "start"
@onready var rhs_coin = 0
@onready var raylie_thanks: AudioStreamPlayer2D = $raylie_thanks
@onready var james_reply: AudioStreamPlayer2D = $james_reply
@onready var panel_container: PanelContainer = $PanelContainer

"""
	TODO : 
		GOOD TO Have:
			Stop the character walking when the dialogue starts
			Custom Dialogue Manager
			Automatic Dialogues
		NEED TO Have:
			Initiate a walk towards the dog the state changes. [Done]
			Animation for dog barking
			Animation for petting dog
			Animation for hugging dog
			Dialogue Play
		WARNINGS:
			Some Error in the dialogue bullon scene need to look further
"""
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	DialogueManager.connect("dialogue_ended", on_dialogue_ended)
	raylie.connect("walk_completed", raylie_completed_walking)
	bruno.dog_barking.connect("finished", bruno_completed_barking)
	bruno.dog_sniffing.connect("finished", bruno_completed_sniffing)
	raylie_thanks.connect("finished", on_raylies_thanks_finished)
	james_reply.connect("finished", on_james_reply_finished)
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	if Input.is_action_just_pressed("ui_left") or Input.is_action_just_pressed( "ui_right"):
		panel_container.hide()
	chapter_one_dialogues()


func distance_between_bruno_and_raylie()->float:
	print("Ray:", raylie.position) # Postion has x and y cordinate
	print("Dog:", bruno.position) # Bruno postion x and y cordinate
	return (bruno.position.x - raylie.position.x)

func chapter_one_dialogues()-> void:
	if ray_to_bruno.is_colliding() and dialogue_initaited==false:
		var origin = ray_to_bruno.global_transform.origin
		var collision_point = ray_to_bruno.get_collision_point()
		var distance = origin.distance_to(collision_point)
		if  distance > 100 and distance < 500: # This should be relative to the frame size for now it's ok
			dialogue_initaited = true
			ch_1_main.action(dialogue)
			
func raylie_completed_walking():
	print("Raylie Completed Walking With Player State ", States.player_state)
	if States.player_state == "PET":
		ch_1_step_2.action(dialogue)

func bruno_completed_barking():
	print(bruno.dog_barking.bus) # to ge
	print("Bruno Completed Barking With Player State ", States.player_state)
	if States.player_state == "PET_WITHOUT_PERMISSION":
		ch_1_pet_without_permission.action(dialogue)
	elif States.player_state == "TOUCH_DOG":
		ch_1_touch_head.action(dialogue)
	elif States.player_state == "ON_HEAD":
		ch_1_pet_over_head.action(dialogue)

func bruno_completed_sniffing():
	if States.player_state == "SMELL_FIST":
		ch_1_step_3.action(dialogue)
		

func on_raylies_thanks_finished():
	james_reply.play()

func on_james_reply_finished():
	raylie.walk_a_distance(2000)
	await get_tree().create_timer(5.0).timeout
	get_tree().change_scene_to_file("res://scenes/Chapter2.tscn")

func on_dialogue_ended(resource:DialogueResource):
	if resource.resource_path == "res://dialogue/main.dialogue":
		print("Dialogue start_step_1 Ended")
		if States.player_state == "PET":
			rhs_coin+=20
			coin_label.updated_coins(rhs_coin)
			ch_1_pet_with_prmission.action(dialogue)
		elif States.player_state == "PET_WITHOUT_PERMISSION":
			bruno.play_dog_barking_sound()
			raylie.walk_toward_bruno(distance_between_bruno_and_raylie())
			
	elif resource.resource_path == "res://dialogue/start_without_permission_to_pet.dialogue":
		print("Dialogue start_without_permission_to_pet ended")
		raylie.walk_toward_bruno(distance_between_bruno_and_raylie())
		
		
	elif resource.resource_path == "res://dialogue/start_with_permission_to_pet.dialogue":
		print("Dialogue start_with_permission_to_pet ended")
		raylie.walk_toward_bruno(distance_between_bruno_and_raylie())
	
	elif resource.resource_path == "res://dialogue/step2.dialogue":
		print("Dialogue start_step_2 ended")
		if States.player_state == "TOUCH_DOG":
			bruno.play_dog_barking_sound()

		elif States.player_state == "SMELL_FIST":
			rhs_coin+=20
			coin_label.updated_coins(rhs_coin)
			ch_1_smell_fist.action(dialogue)
			
	elif resource.resource_path == "res://dialogue/step2_introduce_yourself_by_touching.dialogue":
		print("Dialogue start_touch_dog_without_introduction ended")
		bruno.dog_sniffing.play()
		
	elif resource.resource_path == "res://dialogue/step2_introduce_yourself_by_smell.dialogue":
		print("Dialogue start_introduce_yourself_first ended")
		bruno.dog_sniffing.play()
		
	elif resource.resource_path =="res://dialogue/step3.dialogue":
		print("Dialogue start_step_3 ended")
		if States.player_state == "ON_HEAD":
			bruno.play_dog_barking_sound()
		elif States.player_state == "UNDER_CHIN":
			rhs_coin+=20
			coin_label.updated_coins(rhs_coin)
			ch_1_pet_under_chin.action(dialogue)
			
	elif resource.resource_path == "res://dialogue/step3_pet_over_head.dialogue":
		pass
		
	elif resource.resource_path == "res://dialogue/step3_pet_under_chin.dialogue":
		raylie_thanks.play()
