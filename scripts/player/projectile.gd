class_name Projectile
extends Area2D

@export var speed: float = 400.0
@export var lifetime: float = 2.0
@export var damage: int = 1  # 🆕 ดาเมจต่อนัด

var direction: Vector2 = Vector2.RIGHT


func _ready() -> void:
	get_tree().create_timer(lifetime).timeout.connect(queue_free)
	body_entered.connect(_on_body_entered)


func _physics_process(delta: float) -> void:
	position += direction * speed * delta


func _on_body_entered(body: Node2D) -> void:
	# 🆕 ถ้าสิ่งที่ชนมี HealthComponent ให้ทำดาเมจ
	var health: HealthComponent = body.get_node_or_null("HealthComponent")
	if health:
		health.take_damage(damage)
	queue_free()
