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
	EventBus.player_died.connect(_on_player_died)  # NEW
	_emit_initial_values.call_deferred()

# NEW ผู้เล่นตาย -> ประกาศผลรอบนี้ให้ UI
func _on_player_died() -> void:
	EventBus.run_ended.emit(score, is_new_best)

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
