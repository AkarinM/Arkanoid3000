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
	
#func rect_algorithm():
	#var view = get_viewport().size()
	#var lines = gen_rnd_count_lns(min_line, max_line)
	#
	#var x = view.x
	#var y = view.y
	#
	#var pos_list = []
	#
	#for line in range(lines):
		#for i in range(x):
			#pass
			#
#
#func gen_rnd_count_lns(min_line, max_line):
	#var rng = RandomNumberGenerator.new()
	#
	#return rng.randi_range(min_line, max_line)
	
func _get_texture_size() -> Vector2:
	var scene_block = preload('res://block/block.tscn').instantiate()
	var block:Sprite2D = scene_block.get_node('AnimatedSprite2D')
	
	return block.texture.get_size() * block.scale
