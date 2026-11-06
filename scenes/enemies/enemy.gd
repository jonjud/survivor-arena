class_name Enemy
extends CharacterBody2D

@export var speed: float = 60.0
@export var attack_range: float = 24.0

var target: Node2D

@onready var _state_machine: StateMachine = $StateMachine  # 🆕


func _ready() -> void:
	target = get_tree().get_first_node_in_group("player") as Node2D


# New ให้ระบบภายนอกเรียกเมื่อศัตรูโดนตี
func stun() -> void:
	_state_machine.transition_to(&"Stunned")


# New ปุ่มทดสอบชั่วคราว ลบทิ้งใน task HealthComponent
func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("debug_stun"):
		stun()


func distance_to_target() -> float:
	if target == null:
		return INF
	return global_position.distance_to(target.global_position)
