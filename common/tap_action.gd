extends Control

@export var level_path: String = ''


func _on_gui_input(event: InputEvent) -> void:
	if event.is_pressed():
		Common.change_scene(level_path)
