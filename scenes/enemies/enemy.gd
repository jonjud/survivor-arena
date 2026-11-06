class_name Enemy
extends CharacterBody2D

@export var attack_range: float = 24.0
@export var data: EnemyData
var target: Node2D
var speed: float
var damage: int

@onready var _state_machine: StateMachine = $StateMachine
@onready var _health: HealthComponent = $HealthComponent
@onready var _color_rect: ColorRect = $ColorRect

func _ready() -> void:
	target = get_tree().get_first_node_in_group("player") as Node2D
	_apply_data()
	_health.damaged.connect(_on_damaged)  
	_health.died.connect(_on_died)  

func _apply_data() -> void:
	if data == null:
		push_warning("Enemy: ไม่ได้ใส่ EnemyData")
		return
	speed = data.speed
	damage = data.damage
	_health.max_health = data.max_health
	_health.current_health = data.max_health
	_color_rect.color = data.color

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
