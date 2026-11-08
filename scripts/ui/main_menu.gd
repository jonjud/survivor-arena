class_name MainMenu
extends Control
## หน้าเมนูหลัก แสดงสถิติ และเริ่มเกม

@export var game_scene: PackedScene  # ลาก main.tscn ใส่ใน Inspector

@onready var _best_label: Label = $VBoxContainer/BestLabel
@onready var _play_button: Button = $VBoxContainer/PlayButton
@onready var _quit_button: Button = $VBoxContainer/QuitButton


func _ready() -> void:
	_best_label.text = "Best: %d" % int(SaveSystem.get_value("high_score", 0))
	_play_button.pressed.connect(_on_play_pressed)
	_quit_button.pressed.connect(get_tree().quit)
	# Web ปิดเกมเองไม่ได้ ซ่อนปุ่ม Quit
	_quit_button.visible = not OS.has_feature("web")
	_play_button.grab_focus()  # ให้กด Enter / Space เริ่มเกมได้เลย


func _on_play_pressed() -> void:
	if game_scene == null:
		push_warning("MainMenu: ยังไม่ได้ตั้ง Game Scene")
		return
	get_tree().change_scene_to_packed(game_scene)
