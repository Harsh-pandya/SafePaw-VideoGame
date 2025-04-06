extends Button


func _on_pressed() -> void: ## Play Button Pressed And Called 
	
	get_tree().change_scene_to_file("res://scenes/game_video_player.tscn")
