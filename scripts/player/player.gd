class_name Player
extends CharacterBody2D


@export var speed: float = 150.0
@export var projectile_scene: PackedScene
@export var fire_cooldown: float = 0.25

var _cooldown_left: float = 0.0

@onready var _health: HealthComponent = $HealthComponent  # NEW


func _ready() -> void:
	_health.died.connect(_on_died)
	_health.health_changed.connect(_on_health_changed)  #
	_announce_health.call_deferred()                    #  ประกาศค่าเริ่มต้นหลังทุกฝ่ายต่อสัญญาณเสร็จ


# ส่งต่อเลือดผู้เล่นขึ้น bus
func _on_health_changed(current: int, maximum: int) -> void:
	EventBus.player_health_changed.emit(current, maximum)

#NEW
func _announce_health() -> void:
	EventBus.player_health_changed.emit(_health.current_health, _health.max_health)

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


func _on_died() -> void:
	EventBus.player_died.emit()  # NEW แทน died.emit()
	set_physics_process(false)
	visible = false
