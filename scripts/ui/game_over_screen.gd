class_name GameOverScreen
extends CanvasLayer
## ซ่อนตัวเองไว้ก่อน แล้วแสดงเมื่อผู้เล่นตาย

@onready var _restart_button: Button = $Control/VBoxContainer/RestartButton
@onready var _new_best_label: Label = $Control/VBoxContainer/NewBestLabel  # 

func _ready() -> void:
	hide()
	_new_best_label.hide()  # NEW
	_restart_button.pressed.connect(_on_restart_pressed)
	var player: Player = get_tree().get_first_node_in_group("player") as Player
	if player:
		player.died.connect(_on_player_died)  # NEW

# NEW ตอนตายค่อยเช็กว่าทำสถิติใหม่ไหม แล้วแสดงหน้าจอ
func _on_player_died() -> void:
	var keeper: ScoreKeeper = get_tree().get_first_node_in_group("score_keeper") as ScoreKeeper
	if keeper:
		_new_best_label.visible = keeper.is_new_best
	show()

func _on_restart_pressed() -> void:
	get_tree().reload_current_scene()
