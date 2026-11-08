class_name GameEffects
extends Node
## จับคู่ "เหตุการณ์ในเกม" กับ "เอฟเฟกต์ภาพ"


func _ready() -> void:
	EventBus.enemy_died.connect(_on_enemy_died)


func _on_enemy_died(at_position: Vector2, color: Color) -> void:
	var burst: BurstParticles = BurstParticles.new()
	burst.tint = color
	burst.global_position = at_position
	get_tree().current_scene.add_child(burst)
