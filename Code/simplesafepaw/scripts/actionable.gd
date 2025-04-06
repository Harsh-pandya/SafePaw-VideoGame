extends Node2D


@export var dialogue_resource : DialogueResource


func action(dialogue_start)-> void:
	DialogueManager.show_dialogue_balloon(dialogue_resource, dialogue_start)
