extends Node
## Autoload: เก็บข้อมูล key-value ลงไฟล์ JSON ใน user://

const SAVE_PATH: String = "user://save.json"

var _data: Dictionary = {}
var _loaded: bool = false


func get_value(key: String, default: Variant = null) -> Variant:
	_ensure_loaded()
	return _data.get(key, default)


func set_value(key: String, value: Variant) -> void:
	_ensure_loaded()  # กันเขียนทับไฟล์เดิมด้วย _data ที่ว่าง
	_data[key] = value
	_save_to_disk()


func _ensure_loaded() -> void:
	if _loaded:
		return
	_loaded = true
	if not FileAccess.file_exists(SAVE_PATH):
		print("[Save] ไม่มีไฟล์เซฟ")
		return
	var text: String = FileAccess.get_file_as_string(SAVE_PATH)
	var parsed: Variant = JSON.parse_string(text)
	print("[Save] อ่านไฟล์: '", text, "'")
	if parsed is Dictionary:
		_data = parsed
	else:
		push_warning("SaveSystem: ไฟล์เซฟอ่านไม่ได้")


func _save_to_disk() -> void:
	var file: FileAccess = FileAccess.open(SAVE_PATH, FileAccess.WRITE)
	if file == null:
		push_warning("SaveSystem: เขียนไม่ได้ (error %d)" % FileAccess.get_open_error())
		return
	file.store_string(JSON.stringify(_data))
	file.close()  # ปิดชัด ๆ ให้ flush ลงดิสก์แน่นอน
	# ตัวเช็กชั่วคราว: อ่านกลับทันทีว่าลงดิสก์จริงไหม
	#print("[Save] เขียนแล้ว อ่านกลับ: '", FileAccess.get_file_as_string(SAVE_PATH), "'")
