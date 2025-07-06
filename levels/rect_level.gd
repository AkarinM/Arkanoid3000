extends Node


#@export var lines = 5

var block_size: Vector2 = Vector2.ZERO
var min_line = 3
var max_line = 5
var view: Vector2
var top_bar_size_y
#var inst_obj = null

func _init(block_size, min_line, max_line, view, top_bar_size_y) -> void:
	self.block_size = block_size
	self.min_line = min_line
	self.max_line = max_line
	self.view = view
	self.top_bar_size_y = top_bar_size_y
	

func generate_level():
	var lines = _gen_rnd_count_lns(min_line, max_line)
	var abs_count_blocks_in_line = snapped(view.x / block_size.x, 0.01)  # абсолютное количество блоков, например 12.7 штук
	var count_blocks_in_line = floor(abs_count_blocks_in_line)  # нормальное кол-во блоков, 12 штук
	
	var space_x = 0
	var count_space = 0
	var x = 0
	var y = top_bar_size_y
	var pos_list = []
	
	if abs_count_blocks_in_line != count_blocks_in_line:
		var block_share = (abs_count_blocks_in_line - count_blocks_in_line) * 100  # доля блока, которая не влеза (70%)
		var piece_block = x / 100 * block_share   # сколько пикселей блока не влезло
		count_space = count_blocks_in_line - 1
		space_x = round(piece_block / count_space)
	
	for line in range(1, lines):
		y += block_size.y / 2
		
		for i in range(1, count_blocks_in_line):
			x += block_size.x / 2
			pos_list.append(Vector2(x, y))
			# сдвигаемся на вторую половину блока + пробел
			x += block_size.x / 2 + space_x
		
		# сдвигаемся на вторую половину блока.
		x = 0
		y += block_size.y / 2
		
	return pos_list

func _gen_rnd_count_lns(min_line, max_line):
	var rng = RandomNumberGenerator.new()
	
	return rng.randi_range(min_line, max_line)
