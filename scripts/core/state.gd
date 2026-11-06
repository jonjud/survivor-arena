class_name State
extends Node
## Base class ของทุก state ไม่ผูกกับเกมใดเกมหนึ่ง

# state ส่งสัญญาณนี้เมื่ออยากเปลี่ยนไป state อื่น (ระบุด้วยชื่อ node)
signal transitioned(next_state_name: StringName)


func enter() -> void:
	pass  # เรียกตอนเข้า state


func exit() -> void:
	pass  # เรียกตอนออกจาก state


func update(_delta: float) -> void:
	pass  # เรียกทุกเฟรม (แทน _process)


func physics_update(_delta: float) -> void:
	pass  # เรียกทุกเฟรมฟิสิกส์ (แทน _physics_process)
