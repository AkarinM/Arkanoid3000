extends RigidBody2D

@export var speed: int = 300

var screen_size = 0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	screen_size = get_viewport_rect().size


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	var velocity = Vector2.ZERO
	var action
	
	if !OS.has_feature('editor'):
		pass
	else:
		action = get_action()
	
	velocity.x += action * speed
	position += velocity * delta
	
	position = position.clamp(Vector2.ZERO, screen_size)
	
	
func get_action() -> int:
	var action = 0
	
	if Input.is_action_pressed("ui_right"):
		action = 1
	elif Input.is_action_pressed("ui_left"):
		action = -1
		
	return action
