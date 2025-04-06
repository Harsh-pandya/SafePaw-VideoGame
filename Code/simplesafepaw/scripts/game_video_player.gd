extends Node2D

@onready var chapter_1_intro_video: VideoStreamPlayer = $AspectRatioContainer/chapter_1_intro_video

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	chapter_1_intro_video.play()
	chapter_1_intro_video.connect("finished", on_intro_chapter_1_finished)

func on_intro_chapter_1_finished():
	get_tree().change_scene_to_file("res://scenes/game.tscn")
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
