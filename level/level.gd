extends Node2D

var win = false
var loose = false

var num_blocks = 0
var board_pos_y = 0
var wait_time = 0
var cur_time_obj = null

@export var win_text = 'You win!'
@export var loose_text = 'You loose!'

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	Signals_bus.block_destroyed.connect(_on_block_destroyed)
	Signals_bus.ball_down.connect(_on_ball_dawn)
	Signals_bus.button_press.connect(_on_button_press)

	num_blocks = get_tree().get_nodes_in_group('blocks').size()
	board_pos_y = $Board.position.y
	
	wait_time = $Timer.wait_time
	
	cur_time_obj = get_node('UI/Cur_time')


func _process(delta: float) -> void:
	if win:
		win_game()
	elif loose:
		end_game()
		
	if OS.has_feature('editor'):
		if Input.is_action_just_released('ui_right') or Input.is_action_just_released('ui_left'):
			_on_button_press(0)
		elif Input.is_action_pressed('ui_right'):
			_on_button_press(1)
		elif Input.is_action_pressed('ui_left'):
			_on_button_press(-1)


func _on_block_destroyed():
	num_blocks -= 1
	
	if num_blocks <= 0:
		win = true


func _on_ball_dawn(pos_y):
	if pos_y > board_pos_y:
		loose = true


func win_game():
	var scene_path = 'res://win/win.tscn'
	Common.time = int(cur_time_obj.text)
	
	Common.change_scene(scene_path)


func end_game():
	var scene_path = 'res://loose/loose.tscn'
	
	Common.change_scene(scene_path)


func _on_timer_timeout() -> void:
	var val = int(cur_time_obj.text)
	
	cur_time_obj.text = str(val + wait_time)
	

func _on_button_press(action):
	$Board.set_action(action)
	
