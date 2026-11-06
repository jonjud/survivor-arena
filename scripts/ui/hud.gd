class_name HUD
extends CanvasLayer
## แสดง HP bar ของผู้เล่น โดยฟัง signal ไม่ดึงค่าเอง

@onready var _health_bar: ProgressBar = $MarginContainer/HealthBar
@onready var _wave_label: Label = $TopRight/WaveLabel

func _ready() -> void:
	_connect_player()
	_connect_spawner()  # NEW


func _connect_player() -> void:
	var player: Node = get_tree().get_first_node_in_group("player")
	if player == null:
		push_warning("HUD: ไม่พบผู้เล่นใน group 'player'")
		return
	var health: HealthComponent = player.get_node("HealthComponent")
	health.health_changed.connect(_on_health_changed)
	_on_health_changed(health.current_health, health.max_health)


# NEW ฟังสัญญาณเปลี่ยนคลื่น + ตั้งค่าเริ่มต้นจากค่าปัจจุบัน
func _connect_spawner() -> void:
	var spawner: WaveSpawner = get_tree().get_first_node_in_group("wave_spawner") as WaveSpawner
	if spawner == null:
		push_warning("HUD: ไม่พบ WaveSpawner ใน group 'wave_spawner'")
		return
	spawner.wave_started.connect(_on_wave_started)
	if spawner.wave_number > 0:
		_on_wave_started(spawner.wave_number)


func _on_health_changed(current: int, maximum: int) -> void:
	_health_bar.max_value = maximum
	_health_bar.value = current


# NEW
func _on_wave_started(wave: int) -> void:
	_wave_label.text = "Wave %d" % wave
