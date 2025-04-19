extends Node2D

var win = false
var loose = false

var num_blocks = 0
var board_pos_y = 0

@export var win_text = 'You win!'
@export var loose_text = 'You loose!'

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	Signals_bus.block_destroyed.connect(_on_block_destroyed)
	Signals_bus.ball_down.connect(_on_ball_dawn)

	num_blocks = get_tree().get_nodes_in_group('blocks').size()
	board_pos_y = $Board.position.y
	


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if win or loose:
		end_game()


func _on_block_destroyed():
	num_blocks -= 1
	
	print('num_blocks', num_blocks)
	
	if num_blocks <= 0:
		win = true
		
func _on_ball_dawn(pos_y):
	if pos_y > board_pos_y:
		loose = true


func end_game():
	$Ball.hide()
	$Board.hide()
	
	
	var label = preload('res://label/label.tscn').instantiate()
	var text = win_text if win else loose_text
	
	label.text = text
	
	add_child(label)
