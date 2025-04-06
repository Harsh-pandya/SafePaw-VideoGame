extends CharacterBody2D

@onready var dog_barking: AudioStreamPlayer2D = $DogBarking
@onready var dog_sniffing: AudioStreamPlayer2D = $DogSniffing

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

func play_dog_barking_sound():
	dog_barking.play()
