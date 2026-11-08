class_name PauseMenu
extends CanvasLayer
## หยุดเกมด้วย get_tree().paused ต้องตั้ง Process Mode = Always ที่ node นี้

@onready var _resume_button: Button = $Control/VBoxContainer/ResumeButton
@onready var _menu_button: Button = $Control/VBoxContainer/MainMenuButton

var _run_over: bool = false  # จบรอบแล้ว ไม่ให้ pause ซ้อนกับหน้า Game Over


func _ready() -> void:
	hide()
	_resume_button.pressed.connect(_resume)
	_menu_button.pressed.connect(_on_main_menu_pressed)
	EventBus.run_ended.connect(_on_run_ended)


func _unhandled_input(event: InputEvent) -> void:
	if not event.is_action_pressed("pause") or _run_over:
		return
	if get_tree().paused:
		_resume()
	else:
		_pause()
	get_viewport().set_input_as_handled()


func _pause() -> void:
	get_tree().paused = true
	show()
	_resume_button.grab_focus()  # ให้กด Enter เลือกได้


func _resume() -> void:
	get_tree().paused = false
	hide()


func _on_main_menu_pressed() -> void:
	get_tree().paused = false  # ต้องปลดก่อนเปลี่ยนฉาก ไม่งั้นเมนูหลักค้างนิ่ง
	get_tree().change_scene_to_file(GameScenes.MAIN_MENU)


func _on_run_ended(_score: int, _is_new_best: bool) -> void:
	_run_over = true
