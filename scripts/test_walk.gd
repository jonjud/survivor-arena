extends State

var _time: float = 0.0

func enter() -> void:
	print("เข้า Walk")
	_time = 0.0

func update(delta: float) -> void:
	_time += delta
	if _time >= 2.0:  # ครบ 2 วินาที กลับไป Idle
		transitioned.emit(&"Idle")

func exit() -> void:
	print("ออกจาก Walk")
