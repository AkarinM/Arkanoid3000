extends Node2D

# Настройки визуализации
@export var width := 800
@export var height := 600
@export var max_iterations := 100
@export var threshold := 4.0
@export var color_scheme := 0  # 0 - черно-белый, 1 - цветной

# Область для отрисовки
@export var x_min := -2.5
@export var x_max := 1.0
@export var y_min := -1.0
@export var y_max := 1.0

var texture : ImageTexture
var image : Image

func _ready():
	image = Image.create(width, height, false, Image.FORMAT_RGB8)
	texture = ImageTexture.create_from_image(image)
	update_mandelbrot()

func _draw():
	draw_texture(texture, Vector2.ZERO)

func update_mandelbrot():
	#image.lock()
	
	for x in range(width):
		for y in range(height):
			# Преобразование координат пикселя в комплексную плоскость
			var zx := map(x, 0, width, x_min, x_max)
			var zy := map(y, 0, height, y_min, y_max)
			
			var c := Vector2(zx, zy)
			var z := Vector2(0, 0)
			var iter := 0
			
			# Итеративная проверка принадлежности к множеству
			while iter < max_iterations and z.length_squared() < threshold:
				var tmp := z.x * z.x - z.y * z.y + c.x
				z.y = 2 * z.x * z.y + c.y
				z.x = tmp
				iter += 1
			
			# Установка цвета пикселя
			if iter == max_iterations:
				image.set_pixel(x, y, Color.BLACK)  # Внутри множества
			else:
				var color_value := float(iter) / max_iterations
				if color_scheme == 0:
					# Черно-белая схема
					image.set_pixel(x, y, Color(color_value, color_value, color_value))
				else:
					# Цветная схема
					var hue := color_value * 0.3 + 0.5  # Диапазон оттенков
					image.set_pixel(x, y, Color.from_hsv(hue, 0.8, 0.8))
	
	#image.unlock()
	texture.update(image)
	queue_redraw()

# Вспомогательная функция для преобразования диапазонов
func map(value: float, in_min: float, in_max: float, out_min: float, out_max: float) -> float:
	return (value - in_min) * (out_max - out_min) / (in_max - in_min) + out_min
