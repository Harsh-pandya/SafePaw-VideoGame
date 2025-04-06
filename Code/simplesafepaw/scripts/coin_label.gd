extends Node2D

@onready var label: Label = $HBoxContainer/Label
@onready var coin_sound: AudioStreamPlayer2D = $coin_sound

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass

func updated_coins(coin_number) -> void:
	coin_sound.play()
	label.text = str(coin_number) + " Coins"
