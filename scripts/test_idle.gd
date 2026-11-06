extends State

var _time: float = 0.0

func enter() -> void:
	print("เข้า Idle")
	_time = 0.0

func update(delta: float) -> void:
	_time += delta
	if _time >= 2.0:  # ครบ 2 วินาที สลับไป Walk
		transitioned.emit(&"Walk")

func exit() -> void:
	print("ออกจาก Idle")
