extends RigidBody2D

@export var speed: int = 300

var screen_size = 0
var cur_action = 0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	screen_size = get_viewport_rect().size


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	var velocity = Vector2.ZERO
	
	velocity.x += cur_action * speed
	position += velocity * delta
	
	position = position.clamp(Vector2.ZERO, screen_size)
	

func set_action(action: int):
	cur_action = action
