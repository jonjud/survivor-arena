class_name HUD
extends CanvasLayer
## แสดงผลอย่างเดียว ฟังทุกอย่างจาก EventBus ไม่รู้จัก Player/Spawner/ScoreKeeper

@onready var _health_bar: ProgressBar = $MarginContainer/HealthBar
@onready var _wave_label: Label = $TopRight/VBoxContainer/WaveLabel
@onready var _score_label: Label = $TopRight/VBoxContainer/ScoreLabel
@onready var _best_label: Label = $TopRight/VBoxContainer/BestLabel


func _ready() -> void:
	EventBus.player_health_changed.connect(_on_health_changed)
	EventBus.wave_started.connect(_on_wave_started)
	EventBus.score_changed.connect(_on_score_changed)
	EventBus.high_score_changed.connect(_on_high_score_changed)


func _on_health_changed(current: int, maximum: int) -> void:
	_health_bar.max_value = maximum
	_health_bar.value = current


func _on_wave_started(wave: int) -> void:
	_wave_label.text = "Wave %d" % wave


func _on_score_changed(score: int) -> void:
	_score_label.text = "Score: %d" % score


func _on_high_score_changed(high_score: int) -> void:
	_best_label.text = "Best: %d" % high_score
