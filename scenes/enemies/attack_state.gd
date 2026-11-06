class_name AttackState
extends State
## หยุดอยู่กับที่แล้วโจมตีเป็นจังหวะ ถ้าเป้าหมายออกนอกระยะให้กลับไปไล่

@export var attack_interval: float = 1.0  # ระยะห่างระหว่างการโจมตี (วินาที)

@onready var _enemy: Enemy = owner as Enemy

var _timer: float = 0.0


func enter() -> void:
	_enemy.velocity = Vector2.ZERO  # หยุดเดิน
	_timer = 0.0  # โจมตีทันทีตอนเข้า state


func physics_update(delta: float) -> void:
	# เป้าหมายหนีออกนอกระยะ (เผื่อ 8 px กันสลับ state ถี่ ๆ ตรงขอบระยะ)
	if _enemy.distance_to_target() > _enemy.attack_range + 8.0:
		transitioned.emit(&"Chase")
		return
	_timer -= delta
	if _timer <= 0.0:
		# 🆕 ทำดาเมจจริงให้เป้าหมาย (หา HealthComponent จากชื่อ node)
		var health: HealthComponent = _enemy.target.get_node_or_null("HealthComponent")
		if health:
			health.take_damage(_enemy.damage)
		_timer = attack_interval
