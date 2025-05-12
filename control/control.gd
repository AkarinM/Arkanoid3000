extends Control


func _on_button_press(action: int) -> void:
	Signals_bus.button_press.emit(action)
