class_name HitFlash
extends Node
## วาบขาวเมื่อ HealthComponent ส่ง damaged ใช้กับ node ภาพอะไรก็ได้

@export var health: HealthComponent
@export var sprite: CanvasItem  # Sprite2D หรือ node ภาพอื่น ๆ
@export var flash_time: float = 0.1

const SHADER_CODE: String = """
shader_type canvas_item;
uniform float flash : hint_range(0.0, 1.0) = 0.0;
void fragment() {
	// ผสมสีขาวเข้าไป เก็บ alpha เดิมไว้ (รวม modulate ที่ stun ใช้อยู่)
	COLOR = vec4(mix(COLOR.rgb, vec3(1.0), flash), COLOR.a);
}
"""

var _material: ShaderMaterial
var _tween: Tween


func _ready() -> void:
	if health == null or sprite == null:
		push_warning("HitFlash: ยังไม่ได้ตั้ง health หรือ sprite")
		return
	# สร้าง material ใหม่ให้ตัวนี้โดยเฉพาะ (ไม่แชร์กับ instance อื่น)
	var shader: Shader = Shader.new()
	shader.code = SHADER_CODE
	_material = ShaderMaterial.new()
	_material.shader = shader
	sprite.material = _material
	health.damaged.connect(_on_damaged)


func _on_damaged(_amount: int) -> void:
	if _tween:
		_tween.kill()  # โดนซ้ำเร็ว ๆ ให้เริ่มวาบใหม่
	_material.set_shader_parameter("flash", 1.0)
	_tween = create_tween()
	_tween.tween_property(_material, "shader_parameter/flash", 0.0, flash_time)
