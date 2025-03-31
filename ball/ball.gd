extends RigidBody2D

@export var speed: int = 100


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	linear_velocity = Vector2.DOWN * speed
	
	pass
	


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
