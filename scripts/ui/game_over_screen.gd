class_name GameOverScreen
extends CanvasLayer
## ซ่อนตัวเองไว้ก่อน แล้วแสดงเมื่อผู้เล่นตาย

@onready var _restart_button: Button = $Control/VBoxContainer/RestartButton


func _ready() -> void:
	hide()
	_restart_button.pressed.connect(_on_restart_pressed)
	# หาผู้เล่นผ่าน group แล้วฟัง signal died
	var player: Player = get_tree().get_first_node_in_group("player") as Player
	if player:
		player.died.connect(show)


func _on_restart_pressed() -> void:
	get_tree().reload_current_scene()
