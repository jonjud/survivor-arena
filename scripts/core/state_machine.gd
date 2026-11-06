class_name StateMachine
extends Node
## ถือ state ปัจจุบัน แล้วส่งต่อ update ให้ state นั้น
## state ทั้งหมดคือ child node ของ StateMachine

@export var initial_state: State  # ลาก state เริ่มต้นใส่ใน Inspector

var current_state: State
var _states: Dictionary = {}  # ชื่อ node (lowercase) -> State


func _ready() -> void:
	# รวบรวม state ที่เป็นลูก แล้วฟังสัญญาณ transitioned ของแต่ละตัว
	for child in get_children():
		if child is State:
			_states[child.name.to_lower()] = child
			child.transitioned.connect(_on_state_transitioned)

	if initial_state:
		current_state = initial_state
		current_state.enter()


func _process(delta: float) -> void:
	if current_state:
		current_state.update(delta)


func _physics_process(delta: float) -> void:
	if current_state:
		current_state.physics_update(delta)


func _on_state_transitioned(next_state_name: StringName) -> void:
	var next: State = _states.get(String(next_state_name).to_lower())
	if next == null:
		push_warning("StateMachine: ไม่พบ state '%s'" % next_state_name)
		return
	if next == current_state:
		return
	current_state.exit()
	current_state = next
	current_state.enter()

 #New สั่งเปลี่ยน state จากภายนอก (ใช้ชื่อ node เหมือนสัญญาณ)
func transition_to(state_name: StringName) -> void:
	_on_state_transitioned(state_name)
