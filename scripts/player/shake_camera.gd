class_name ShakeCamera
extends Camera2D
## กล้องที่สั่นได้ ขยับ offset ไม่แตะ position (ไม่ชนกับ smoothing)

var _strength: float = 0.0   # แรงสั่นตั้งต้น (pixel)
var _duration: float = 0.0   # ระยะเวลาสั่นทั้งหมด
var _time_left: float = 0.0


func _ready() -> void:
	EventBus.player_damaged.connect(_on_player_damaged)
	EventBus.enemy_killed.connect(_on_enemy_killed)


## สั่งสั่น ถ้ากำลังสั่นแรงกว่าอยู่แล้ว จะไม่ถูกแทนที่ด้วยแรงที่เบากว่า
func shake(strength: float, duration: float) -> void:
	var current: float = _strength * (_time_left / _duration) if _duration > 0.0 else 0.0
	if strength < current:
		return
	_strength = strength
	_duration = duration
	_time_left = duration


func _process(delta: float) -> void:
	if _time_left <= 0.0:
		offset = Vector2.ZERO
		return
	_time_left -= delta
	var fade: float = maxf(_time_left / _duration, 0.0)  # ค่อย ๆ นิ่ง
	var jitter: Vector2 = Vector2(randf_range(-1.0, 1.0), randf_range(-1.0, 1.0))
	offset = (jitter * _strength * fade).round()  # ปัดเป็นพิกเซลเต็ม กัน pixel art เบลอ


func _on_player_damaged() -> void:
	shake(5.0, 0.25)


func _on_enemy_killed(_score_value: int) -> void:
	shake(1.5, 0.1)
