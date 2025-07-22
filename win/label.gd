extends Label

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var text_score = 'Score: {0}'.format([Common.score])
	var text_time = 'Time: {0}'.format([Common.time])
	text = """
	{0}
	{1}
	{2}
	""".format([text, text_score, text_time])
