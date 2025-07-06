extends Node

var min_line = 3
var max_line = 5

var block_obj: PackedScene

var algorithms = ['_rect_algorithm']
var block_size: Vector2 = Vector2.ZERO
var view: Vector2 = Vector2.ZERO
var top_bar_size_y = 0
var level_obj = null

# Called when the node enters the scene tree for the first time.
func _init(view, top_bar_size_y, block_obj, level_obj) -> void:
	var algorithm = algorithms.pick_random()
	self.view = view
	block_size = _get_texture_size()
	
	self.top_bar_size_y = top_bar_size_y
	self.block_obj = block_obj
	self.level_obj = level_obj
	
	var pos_list = call(algorithm, view)
	
	_draw_level(pos_list)
	

func _rect_algorithm(view):
	var script = load("res://levels/rect_level.gd").new(block_size, min_line, max_line, view, top_bar_size_y)
	
	return script.generate_level()
	

func _draw_level(pos_list):	
	for vector in pos_list:
		var block = block_obj.instantiate()
		block.position = vector
		
		level_obj.add_child(block)


func _get_texture_size() -> Vector2:
	var scene_block = preload('res://block/block.tscn').instantiate()
	var block:Sprite2D = scene_block.get_node('AnimatedSprite2D')
	
	return block.texture.get_size() * block.scale
