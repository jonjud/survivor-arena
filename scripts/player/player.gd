class_name Player
extends CharacterBody2D

signal died  # NEW Player ส่งสัญญาณต่อให้ระบบภายนอก (UI) ฟัง

@export var speed: float = 150.0
@export var projectile_scene: PackedScene
@export var fire_cooldown: float = 0.25

var _cooldown_left: float = 0.0

@onready var _health: HealthComponent = $HealthComponent  # NEW


func _ready() -> void:
	_health.died.connect(_on_died)  # NEW


func _physics_process(delta: float) -> void:
	var direction: Vector2 = Input.get_vector(
		"move_left", "move_right", "move_up", "move_down"
	)
	velocity = direction * speed
	move_and_slide()

	_cooldown_left -= delta
	if Input.is_action_pressed("shoot") and _cooldown_left <= 0.0:
		_shoot()
		_cooldown_left = fire_cooldown


func _shoot() -> void:
	var projectile: Projectile = projectile_scene.instantiate()
	projectile.global_position = global_position
	projectile.direction = (get_global_mouse_position() - global_position).normalized()
	get_tree().current_scene.add_child(projectile)


# NEW ตาย -> ส่งสัญญาณแล้วหยุดทำงาน (ไม่ลบตัว เพื่อให้กล้องยังอยู่)
func _on_died() -> void:
	died.emit()
	set_physics_process(false)
	visible = false
