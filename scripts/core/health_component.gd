class_name HealthComponent
extends Node
## เก็บเลือดและส่ง signal ไม่ผูกกับเกมนี้ ใส่กับ node ไหนก็ได้

signal damaged(amount: int)            # โดนดาเมจ (ยังไม่ตาย)
signal died                            # เลือดหมด
signal health_changed(current: int, maximum: int)  # ไว้ใช้กับ HP bar ทีหลัง

@export var max_health: int = 10

var current_health: int


func _ready() -> void:
	current_health = max_health


func take_damage(amount: int) -> void:
	if current_health <= 0:
		return  # ตายแล้ว ไม่รับดาเมจซ้ำ (กัน died ยิงสองรอบ)
	current_health = maxi(current_health - amount, 0)
	health_changed.emit(current_health, max_health)
	if current_health > 0:
		damaged.emit(amount)
	else:
		died.emit()


func heal(amount: int) -> void:
	if current_health <= 0:
		return
	current_health = mini(current_health + amount, max_health)
	health_changed.emit(current_health, max_health)
