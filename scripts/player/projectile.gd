class_name Projectile
extends Area2D

@export var speed: float = 400.0     
@export var lifetime: float = 2.0    

var direction: Vector2 = Vector2.RIGHT  

func _ready() -> void:
	# ลบตัวเองเมื่อหมดเวลา (กันกระสุนค้างในฉากตลอดไป)
	get_tree().create_timer(lifetime).timeout.connect(queue_free)
	body_entered.connect(_on_body_entered) # New ฟังสัญญาณเมื่อชนวัตถุ

func _physics_process(delta: float) -> void:
	position += direction * speed * delta

func _on_body_entered(_body: Node2D) -> void:
	queue_free()
