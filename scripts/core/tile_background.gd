class_name TiledBackground
extends Sprite2D
## พื้นหลังกระเบื้องไม่รู้จบ ปูเท่าขนาดจอ แล้วเลื่อนตามกล้องทีละช่องเต็มกระเบื้อง
## ต้องตั้ง Texture ใน Inspector (ภาพที่ต่อซ้ำได้เนียน)

@export var tile_size: int = 32  # ขนาดกระเบื้อง ต้องเท่ากับความกว้างของภาพ


func _ready() -> void:
	texture_repeat = CanvasItem.TEXTURE_REPEAT_ENABLED
	centered = true
	region_enabled = true
	z_index = -100  # อยู่หลังทุกอย่าง
	# ปูให้ใหญ่กว่าจอ เผื่อ 3 ช่อง กันเห็นขอบตอนกล้องสั่นและเลื่อน
	var view: Vector2 = get_viewport_rect().size
	var cols: int = ceili(view.x / tile_size) + 3
	var rows: int = ceili(view.y / tile_size) + 3
	region_rect = Rect2(0, 0, cols * tile_size, rows * tile_size)


func _process(_delta: float) -> void:
	var camera: Camera2D = get_viewport().get_camera_2d()
	if camera == null:
		return
	# เลื่อนตามกล้องแบบ snap เป็นช่องเต็ม ลายจึงนิ่งกับโลก
	var center: Vector2 = camera.get_screen_center_position()
	global_position = (center / tile_size).floor() * tile_size
