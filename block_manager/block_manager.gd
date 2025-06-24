extends Node

@export var min_line = 3
@export var max_line = 5
@export var block_obj: PackedScene

var algorithms = ['_rect_algorithm']
var block_size: Vector2 = Vector2.ZERO
var view: Vector2 = Vector2.ZERO

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var algorithm = algorithms.pick_random()
	view = get_viewport().get_visible_rect().size
	block_size = _get_texture_size()
	
	var pos_list = call(algorithm, view)
	
	_draw_level(pos_list)
	

func _rect_algorithm(view):
	var script = load("res://levels/rect_level.gd").new(block_size, min_line, max_line, view)
	
	return script.generate_level()
	

func _draw_level(pos_list):	
	for vector in pos_list:
		var block = block_obj.instantiate()
		block.position = vector
		
		add_child(block)


func _get_texture_size() -> Vector2:
	var scene_block = preload('res://block/block.tscn').instantiate()
	var block:Sprite2D = scene_block.get_node('AnimatedSprite2D')
	
	return block.texture.get_size() * block.scale
