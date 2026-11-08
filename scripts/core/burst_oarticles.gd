class_name BurstParticles
extends CPUParticles2D
## เศษกระจายครั้งเดียวแล้วลบตัวเอง สร้างด้วย BurstParticles.new()

var tint: Color = Color.WHITE  # ตั้งก่อน add_child


func _ready() -> void:
	one_shot = true
	explosiveness = 1.0           # พุ่งออกพร้อมกันทั้งหมด
	amount = 12
	lifetime = 0.45
	direction = Vector2.UP
	spread = 180.0                # กระจายรอบทิศ
	gravity = Vector2.ZERO        # เกม top-down ไม่มีแรงโน้มถ่วง
	initial_velocity_min = 50.0
	initial_velocity_max = 130.0
	damping_min = 60.0            # ค่อย ๆ ช้าลง
	damping_max = 100.0
	scale_amount_min = 2.0        # ไม่มี texture จึงเป็นสี่เหลี่ยมเล็ก ๆ ตามขนาดนี้
	scale_amount_max = 3.0
	color = tint

	# จางหายไปตามอายุ
	var fade: Gradient = Gradient.new()
	fade.offsets = PackedFloat32Array([0.0, 1.0])
	fade.colors = PackedColorArray([Color(1, 1, 1, 1), Color(1, 1, 1, 0)])
	color_ramp = fade

	emitting = true
	# ลบตัวเองเมื่อเล่นจบ (ไม่ให้ node ค้างในฉาก)
	get_tree().create_timer(lifetime + 0.1).timeout.connect(queue_free)
