class_name Projectile
extends Area2D

@export var speed: float = 400.0     # ความเร็วกระสุน (pixel/วินาที)
@export var lifetime: float = 2.0    # ลบตัวเองหลังกี่วินาที

var direction: Vector2 = Vector2.RIGHT  # Player เป็นคนกำหนดตอนยิง

func _ready() -> void:
	# ลบตัวเองเมื่อหมดเวลา (กันกระสุนค้างในฉากตลอดไป)
	get_tree().create_timer(lifetime).timeout.connect(queue_free)

func _physics_process(delta: float) -> void:
	position += direction * speed * delta
