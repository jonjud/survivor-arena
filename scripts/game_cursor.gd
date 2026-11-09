class_name GameCursor
extends Node
## เปลี่ยนเคอร์เซอร์เป็นกากบาทเฉพาะตอนอยู่ในฉากเกม

@export var crosshair: Texture2D  # ภาพ 32x32 จุดเล็งอยู่กึ่งกลาง


func _ready() -> void:
	if crosshair == null:
		push_warning("GameCursor: ยังไม่ได้ตั้ง crosshair")
		return
	# hotspot = จุดที่นับว่าคลิก ใช้กึ่งกลางภาพ
	Input.set_custom_mouse_cursor(crosshair, Input.CURSOR_ARROW, crosshair.get_size() / 2.0)


func _exit_tree() -> void:
	# ออกจากฉากเกม (กลับเมนู) คืนเคอร์เซอร์ปกติ
	Input.set_custom_mouse_cursor(null)
