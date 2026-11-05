class_name Player
extends CharacterBody2D

@export var speed: float = 150.0  # ความเร็วเดิน (pixel/วินาที)


func _physics_process(_delta: float) -> void:
	# อ่านทิศทางจาก input (normalize แล้ว เดินเฉียงไม่เร็วขึ้น)
	var direction: Vector2 = Input.get_vector(
		"move_left", "move_right", "move_up", "move_down"
	)
	velocity = direction * speed
	move_and_slide()  # เคลื่อนที่ + จัดการการชน
