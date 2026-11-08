extends Node
## Autoload: ศูนย์กลางสัญญาณระดับเกม ไม่มีตรรกะ มีแต่ signal

signal enemy_killed(score_value: int)
signal score_changed(score: int)
signal high_score_changed(high_score: int)

signal player_health_changed(current: int, maximum: int)  
signal player_died                                        
signal wave_started(wave_number: int)                     
signal run_ended(score: int, is_new_best: bool)           # จบรอบ (ประกาศโดย ScoreKeeper)

signal projectile_fired            
signal enemy_damaged               

signal player_damaged
