class_name WaveSpawner
extends Node2D
## เกิดศัตรูตามเวลาที่ขอบจอรอบผู้เล่น

@export var enemy_scene: PackedScene
@export var enemy_types: Array[EnemyData] = []  # ชนิดที่สุ่มเลือก
@export var spawn_interval: float = 2.0         # ห่างกันกี่วินาที
@export var spawn_margin: float = 40.0          # เผื่อให้เกิดนอกขอบจอกี่ pixel

var _timer: float = 0.0
var _player: Node2D


func _ready() -> void:
	_player = get_tree().get_first_node_in_group("player") as Node2D
	_timer = spawn_interval


func _process(delta: float) -> void:
	if _player == null or not _player.visible:
		return  # ผู้เล่นตายแล้ว หยุดเกิด
	_timer -= delta
	if _timer <= 0.0:
		_spawn_enemy()
		_timer = spawn_interval


func _spawn_enemy() -> void:
	if enemy_scene == null or enemy_types.is_empty():
		push_warning("WaveSpawner: ยังไม่ได้ตั้ง enemy_scene หรือ enemy_types")
		return
	var enemy: Enemy = enemy_scene.instantiate()
	enemy.data = enemy_types.pick_random()  # ต้องตั้งก่อน add_child (ให้ _ready อ่านได้)
	enemy.global_position = _random_edge_position()
	get_tree().current_scene.add_child(enemy)


# สุ่มจุดบนกรอบสี่เหลี่ยมที่ใหญ่กว่าหน้าจอเล็กน้อย รอบตัวผู้เล่น
func _random_edge_position() -> Vector2:
	var half: Vector2 = get_viewport_rect().size / 2.0 + Vector2(spawn_margin, spawn_margin)
	var side: int = randi() % 4
	var offset: Vector2
	match side:
		0: offset = Vector2(randf_range(-half.x, half.x), -half.y)  # บน
		1: offset = Vector2(randf_range(-half.x, half.x), half.y)   # ล่าง
		2: offset = Vector2(-half.x, randf_range(-half.y, half.y))  # ซ้าย
		_: offset = Vector2(half.x, randf_range(-half.y, half.y))   # ขวา
	return _player.global_position + offset
