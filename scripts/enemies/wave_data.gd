class_name WaveData
extends Resource
## ข้อมูลคลื่นศัตรู 1 คลื่น เก็บเป็นไฟล์ .tres

@export var enemy_types: Array[EnemyData] = []  # ชนิดที่สุ่มเลือกในคลื่นนี้
@export var enemy_count: int = 5                # จำนวนศัตรูทั้งคลื่น
@export var spawn_interval: float = 2.0         # ห่างกันกี่วินาที
@export var delay_before: float = 2.0           # พักก่อนเริ่มคลื่น (วินาที)
