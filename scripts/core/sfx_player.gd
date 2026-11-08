extends Node
## Autoload: เล่นเอฟเฟกต์เสียงสั้น ๆ ผ่าน pool เล่นซ้อนกันได้

const POOL_SIZE: int = 8

var _players: Array[AudioStreamPlayer] = []
var _next: int = 0


func _ready() -> void:
	for i in POOL_SIZE:
		var p: AudioStreamPlayer = AudioStreamPlayer.new()
		add_child(p)
		_players.append(p)


## เล่นเสียง pitch_variation = สุ่มระดับเสียงเล็กน้อย กันเสียงซ้ำจนน่าเบื่อ
func play(stream: AudioStream, volume_db: float = 0.0, pitch_variation: float = 0.0) -> void:
	if stream == null:
		return
	var p: AudioStreamPlayer = _players[_next]
	_next = (_next + 1) % POOL_SIZE  # หมุนวนใช้ตัวถัดไป
	p.stream = stream
	p.volume_db = volume_db
	p.pitch_scale = 1.0 + randf_range(-pitch_variation, pitch_variation)
	p.play()
