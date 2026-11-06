class_name Enemy
extends CharacterBody2D

@export var speed: float = 60.0
@export var attack_range: float = 24.0  # 🆕 ระยะที่เริ่มโจมตี (pixel)

var target: Node2D


func _ready() -> void:
	target = get_tree().get_first_node_in_group("player") as Node2D


# New ระยะห่างถึงเป้าหมาย (ใช้ร่วมกันหลาย state)
func distance_to_target() -> float:
	if target == null:
		return INF
	return global_position.distance_to(target.global_position)
