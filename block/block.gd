extends RigidBody2D

func _on_body_entered(body: Node) -> void:
	if body.name == 'Ball':
		queue_free()
		await tree_exited
		Signals_bus.block_destroyed.emit()
