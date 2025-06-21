extends RigidBody2D


func _on_body_entered(body: Node) -> void:
	if body.name == 'Ball':
		Signals_bus.ball_down.emit(body.position.y)
