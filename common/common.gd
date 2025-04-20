extends Node

func change_scene(path):
	if path != '':
		get_tree().change_scene_to_file(path)
