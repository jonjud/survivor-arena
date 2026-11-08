class_name ScoreKeeper
extends Node
## รวมคะแนน + high score ฟัง EventBus แล้วประกาศผลกลับทาง EventBus

const HIGH_SCORE_KEY: String = "high_score"

var score: int = 0
var high_score: int = 0
var is_new_best: bool = false


func _init() -> void:
	high_score = int(SaveSystem.get_value(HIGH_SCORE_KEY, 0))


func _ready() -> void:
	EventBus.enemy_killed.connect(add_score)
	# ประกาศค่าเริ่มต้นหลังทุก node _ready เสร็จ (ไม่พึ่งลำดับ node ใน scene)
	_emit_initial_values.call_deferred()


func add_score(amount: int) -> void:
	score += amount
	EventBus.score_changed.emit(score)
	if score > high_score:
		high_score = score
		is_new_best = true
		SaveSystem.set_value(HIGH_SCORE_KEY, high_score)
		EventBus.high_score_changed.emit(high_score)


func _emit_initial_values() -> void:
	EventBus.score_changed.emit(score)
	EventBus.high_score_changed.emit(high_score)
