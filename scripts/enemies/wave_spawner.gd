class_name WaveSpawner
extends Node2D
## เล่นคลื่นศัตรูจาก WaveData เรียงตามลำดับ

signal wave_started(wave_number: int)  # ไว้ใช้กับ UI ใน task ถัดไป

@export var enemy_scene: PackedScene
@export var waves: Array[WaveData] = []
@export var spawn_margin: float = 40.0

var wave_number: int = 0  # คลื่นที่กำลังเล่น (เริ่มนับที่ 1)

var _player: Node2D
var _wave: WaveData
var _spawned: int = 0
var _timer: float = 0.0


func _ready() -> void:
	_player = get_tree().get_first_node_in_group("player") as Node2D
	_start_next_wave()


func _process(delta: float) -> void:
	if _player == null or not _player.visible or _wave == null:
		return  # ผู้เล่นตายแล้ว หยุดเกิด

	_timer -= delta
	if _timer > 0.0:
		return

	if _spawned < _wave.enemy_count:
		_spawn_enemy()
		_spawned += 1
		_timer = _wave.spawn_interval
	else:
		_start_next_wave()  # เกิดครบแล้ว ขึ้นคลื่นถัดไป


func _start_next_wave() -> void:
	if waves.is_empty():
		push_warning("WaveSpawner: ยังไม่ได้ใส่ waves")
		return
	wave_number += 1
	# คลื่นสุดท้ายวนซ้ำ (เกินจำนวนที่มีให้ใช้คลื่นสุดท้ายต่อ)
	_wave = waves[mini(wave_number, waves.size()) - 1]
	_spawned = 0
	_timer = _wave.delay_before
	wave_started.emit(wave_number)
	print("เริ่มคลื่นที่ ", wave_number)  # ชั่วคราว ไว้เช็ก


func _spawn_enemy() -> void:
	if enemy_scene == null or _wave.enemy_types.is_empty():
		push_warning("WaveSpawner: ยังไม่ได้ตั้ง enemy_scene หรือ enemy_types")
		return
	var enemy: Enemy = enemy_scene.instantiate()
	enemy.data = _wave.enemy_types.pick_random()  # ตั้งก่อน add_child
	enemy.global_position = _random_edge_position()
	enemy.global_position = _random_edge_position()
	# NEW ต่อสัญญาณคะแนนเข้า ScoreKeeper
	var keeper: ScoreKeeper = get_tree().get_first_node_in_group("score_keeper") as ScoreKeeper
	if keeper:
		enemy.killed.connect(keeper.add_score)
	get_tree().current_scene.add_child(enemy)


func _random_edge_position() -> Vector2:
	var half: Vector2 = get_viewport_rect().size / 2.0 + Vector2(spawn_margin, spawn_margin)
	var side: int = randi() % 4
	var offset: Vector2
	match side:
		0: offset = Vector2(randf_range(-half.x, half.x), -half.y)
		1: offset = Vector2(randf_range(-half.x, half.x), half.y)
		2: offset = Vector2(-half.x, randf_range(-half.y, half.y))
		_: offset = Vector2(half.x, randf_range(-half.y, half.y))
	return _player.global_position + offset
