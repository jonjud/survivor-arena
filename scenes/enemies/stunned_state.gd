class_name StunnedState
extends State
## หยุดนิ่งชั่วคราว แล้วกลับไปไล่ต่อเมื่อหมดเวลา

@export var stun_duration: float = 1.0  # ระยะเวลา stun (วินาที)

@onready var _enemy: Enemy = owner as Enemy

var _timer: float = 0.0


func enter() -> void:
	_enemy.velocity = Vector2.ZERO
	_timer = stun_duration
	_enemy.modulate = Color(1, 1, 0.4)  # ย้อมเหลืองให้เห็นว่ากำลัง stun


func exit() -> void:
	_enemy.modulate = Color.WHITE  # คืนสีปกติ


func physics_update(delta: float) -> void:
	_timer -= delta
	if _timer <= 0.0:
		transitioned.emit(&"Chase")
