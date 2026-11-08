class_name GameAudio
extends Node
## จับคู่ "เหตุการณ์ในเกม" กับ "เสียง" ลากไฟล์ใส่ใน Inspector

@export var shoot_sfx: AudioStream
@export var hit_sfx: AudioStream
@export var death_sfx: AudioStream


func _ready() -> void:
	EventBus.projectile_fired.connect(_on_projectile_fired)
	EventBus.enemy_damaged.connect(_on_enemy_damaged)
	EventBus.enemy_killed.connect(_on_enemy_killed)


func _on_projectile_fired() -> void:
	SfxPlayer.play(shoot_sfx, -8.0, 0.08)


func _on_enemy_damaged() -> void:
	SfxPlayer.play(hit_sfx, -4.0, 0.1)


func _on_enemy_killed(_score_value: int) -> void:
	SfxPlayer.play(death_sfx, -2.0, 0.05)
