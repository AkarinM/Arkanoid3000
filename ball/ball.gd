extends RigidBody2D

@export var speed: int = 100

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var rng = RandomNumberGenerator.new()
	var x = rng.randf_range(-2, 2)
	
	linear_velocity = Vector2(x, 1).normalized() * speed
	


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
		
