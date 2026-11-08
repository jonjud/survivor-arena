extends Node
## Autoload: ศูนย์กลางสัญญาณระดับเกม ไม่มีตรรกะ มีแต่ signal
## ผู้ส่งเรียก EventBus.xxx.emit() ผู้ฟังเรียก EventBus.xxx.connect()

signal enemy_killed(score_value: int)  # มีศัตรูตาย พร้อมคะแนนที่ได้
signal score_changed(score: int)       # คะแนนรอบนี้เปลี่ยน
signal high_score_changed(high_score: int)  # สถิติสูงสุดเปลี่ยน
