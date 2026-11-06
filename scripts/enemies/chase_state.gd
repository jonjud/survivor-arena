class_name ChaseState
extends State

@onready var _enemy: Enemy = owner as Enemy


func physics_update(_delta: float) -> void:
	if _enemy.target == null:
		return
	# New ถึงระยะโจมตีแล้ว ส่งสัญญาณขอเปลี่ยนเป็น Attack
	if _enemy.distance_to_target() <= _enemy.attack_range:
		transitioned.emit(&"Attack")
		return
	var direction: Vector2 = _enemy.global_position.direction_to(_enemy.target.global_position)
	_enemy.velocity = direction * _enemy.speed
	_enemy.move_and_slide()
