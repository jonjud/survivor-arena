class_name Enemy
extends CharacterBody2D

@export var speed: float = 60.0
@export var attack_range: float = 24.0
@export var damage: int = 1  # NEW ดาเมจต่อการโจมตี
var target: Node2D

@onready var _state_machine: StateMachine = $StateMachine
@onready var _health: HealthComponent = $HealthComponent  # NEW


func _ready() -> void:
	target = get_tree().get_first_node_in_group("player") as Node2D
	_health.damaged.connect(_on_damaged)  # NEW
	_health.died.connect(_on_died)        # NEW


func stun() -> void:
	_state_machine.transition_to(&"Stunned")


# NEW โดนดาเมจแต่ยังไม่ตาย -> stun
func _on_damaged(_amount: int) -> void:
	stun()


# NEW ตาย -> พิมพ์ข้อความแล้วลบตัวเอง
func _on_died() -> void:
	print("ศัตรูตาย")
	queue_free()


# NEW ปุ่มทดสอบชั่วคราว (แทน debug_stun) ลบทิ้งตอนผูกกับกระสุน
func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("debug_damage"):
		_health.take_damage(1)


func distance_to_target() -> float:
	if target == null:
		return INF
	return global_position.distance_to(target.global_position)
