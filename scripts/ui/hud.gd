class_name HUD
extends CanvasLayer
## แสดง HP bar ของผู้เล่น โดยฟัง signal ไม่ดึงค่าเอง

@onready var _health_bar: ProgressBar = $MarginContainer/HealthBar


func _ready() -> void:
	var player: Node = get_tree().get_first_node_in_group("player")
	if player == null:
		push_warning("HUD: ไม่พบผู้เล่นใน group 'player'")
		return
	var health: HealthComponent = player.get_node("HealthComponent")
	health.health_changed.connect(_on_health_changed)
	# ตั้งค่าเริ่มต้นให้ตรงกับเลือดจริง (signal ยังไม่ถูกยิงตอนเริ่มเกม)
	_on_health_changed(health.current_health, health.max_health)


func _on_health_changed(current: int, maximum: int) -> void:
	_health_bar.max_value = maximum
	_health_bar.value = current
