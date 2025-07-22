extends RigidBody2D

var val_score = 0

func _init():
	var rnd = RandomNumberGenerator.new()
	
	val_score = rnd.randi_range(10, 30)

func _on_body_entered(body: Node) -> void:
	if body.name == 'Ball':
		queue_free()
		await tree_exited
		Signals_bus.block_destroyed.emit(val_score)
