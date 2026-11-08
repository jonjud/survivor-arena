class_name GameOverScreen
extends CanvasLayer
## ซ่อนไว้ก่อน แล้วแสดงเมื่อจบรอบ

@onready var _restart_button: Button = $Control/VBoxContainer/RestartButton
@onready var _new_best_label: Label = $Control/VBoxContainer/NewBestLabel


func _ready() -> void:
	hide()
	_new_best_label.hide()
	_restart_button.pressed.connect(_on_restart_pressed)
	EventBus.run_ended.connect(_on_run_ended)


func _on_run_ended(_score: int, is_new_best: bool) -> void:
	_new_best_label.visible = is_new_best
	show()


func _on_restart_pressed() -> void:
	get_tree().reload_current_scene()
