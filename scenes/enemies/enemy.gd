class_name Enemy
extends CharacterBody2D

@export var attack_range: float = 24.0
@export var data: EnemyData
var target: Node2D
var speed: float
var damage: int

@onready var _state_machine: StateMachine = $StateMachine
@onready var _health: HealthComponent = $HealthComponent
@onready var _sprite: Sprite2D = $Sprite2D
@onready var _collision: CollisionShape2D = $CollisionShape2D


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
	_sprite.texture = data.texture  # 🆕 แทนการตั้งสีและขนาด ColorRect
	# ปรับขนาด collision ตามชนิด (สร้าง shape ใหม่ทุกตัว ไม่แชร์กัน)
	var shape: RectangleShape2D = RectangleShape2D.new()
	shape.size = Vector2(data.size, data.size)
	_collision.shape = shape

func stun() -> void:
	_state_machine.transition_to(&"Stunned")


# NEW โดนดาเมจแต่ยังไม่ตาย -> stun
func _on_damaged(_amount: int) -> void:
	EventBus.enemy_damaged.emit()  # 🆕
	stun()


# NEW ตาย -> พิมพ์ข้อความแล้วลบตัวเอง
func _on_died() -> void:
	EventBus.enemy_killed.emit(data.score_value if data else 0)  # 🆕 แทน killed
	queue_free()



func distance_to_target() -> float:
	if target == null:
		return INF
	return global_position.distance_to(target.global_position)
