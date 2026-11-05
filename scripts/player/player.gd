class_name Player
extends CharacterBody2D

@export var speed: float = 150.0
@export var projectile_scene: PackedScene          
@export var fire_cooldown: float = 0.25            # New : ระยะห่างระหว่างนัด (วินาที)

var _cooldown_left: float = 0.0                    # New : เวลาที่เหลือก่อนยิงได้อีก


func _physics_process(delta: float) -> void:       # New : เปลี่ยน _delta เป็น delta (ใช้แล้ว)
	var direction: Vector2 = Input.get_vector(
		"move_left", "move_right", "move_up", "move_down"
	)
	velocity = direction * speed
	move_and_slide()

	# 🆕 นับ cooldown ลง แล้วยิงถ้าพร้อมและกดปุ่มค้างอยู่
	_cooldown_left -= delta
	if Input.is_action_pressed("shoot") and _cooldown_left <= 0.0:
		_shoot()
		_cooldown_left = fire_cooldown


# New : สร้างกระสุนที่ตำแหน่งผู้เล่น หันไปทางเมาส์
func _shoot() -> void:
	var projectile: Projectile = projectile_scene.instantiate()
	projectile.global_position = global_position
	projectile.direction = (get_global_mouse_position() - global_position).normalized()
	# เพิ่มเป็นลูกของ scene หลัก ไม่ใช่ของ Player (ไม่งั้นกระสุนจะเคลื่อนตามผู้เล่น)
	get_tree().current_scene.add_child(projectile)
