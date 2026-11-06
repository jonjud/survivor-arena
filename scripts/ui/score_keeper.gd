class_name ScoreKeeper
extends Node
## รวมคะแนน ไม่รู้จักศัตรูหรือ UI รับแค่ค่าที่ส่งมา

signal score_changed(score: int)

var score: int = 0


func add_score(amount: int) -> void:
	score += amount
	score_changed.emit(score)
