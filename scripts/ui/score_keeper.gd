class_name ScoreKeeper
extends Node
## รวมคะแนน + จัดการ high score

signal score_changed(score: int)
signal high_score_changed(high_score: int)

const HIGH_SCORE_KEY: String = "high_score"

var score: int = 0
var high_score: int = 0
var is_new_best: bool = false


func _init() -> void:
	# โหลดตอนสร้าง node ให้พร้อมก่อน HUD._ready
	high_score = int(SaveSystem.get_value(HIGH_SCORE_KEY, 0))
	#print("[Score] high_score ตอนเริ่ม = ", high_score)


func add_score(amount: int) -> void:
	score += amount
	score_changed.emit(score)
	if score > high_score:
		high_score = score
		is_new_best = true
		SaveSystem.set_value(HIGH_SCORE_KEY, high_score)
		high_score_changed.emit(high_score)
