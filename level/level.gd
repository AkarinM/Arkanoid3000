extends Node2D

var win = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	Signals_bus.block_destroyed.connect(_on_block_destroyed)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if win:
		you_win()


func count_blocks() -> int:
	return get_tree().get_nodes_in_group('blocks').size()
	

func _on_block_destroyed():
	var count = count_blocks()
	print('count', count)
	
	if count == 0:
		print('dddddddd')
		win = true
		

func you_win():
	$Ball.hide()
	$Board.hide()
	
	print('YOU WIN!!!')
	
