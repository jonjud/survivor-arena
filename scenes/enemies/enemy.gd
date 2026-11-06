class_name Enemy
extends CharacterBody2D

@export var speed: float = 60.0  # ความเร็ววิ่งไล่ (pixel/วินาที)

var target: Node2D  # เป้าหมายที่ไล่ (ผู้เล่น)


func _ready() -> void:
	# หาผู้เล่นผ่าน group ไม่ผูกกับ path ใน scene tree
	target = get_tree().get_first_node_in_group("player") as Node2D
