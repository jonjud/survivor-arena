class_name ChaseState
extends State
## วิ่งไล่ target ของ Enemy ที่เป็นเจ้าของ

@onready var _enemy: Enemy = owner as Enemy


func physics_update(_delta: float) -> void:
	if _enemy.target == null:
		return
	# ทิศไปหาเป้าหมาย (normalize ให้ความเร็วคงที่ไม่ว่าไกลแค่ไหน)
	var direction: Vector2 = _enemy.global_position.direction_to(_enemy.target.global_position)
	_enemy.velocity = direction * _enemy.speed
	_enemy.move_and_slide()
