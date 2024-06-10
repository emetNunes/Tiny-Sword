extends Node

var time: float = 0.0

@export var spawn_rate_per_minute: float = 30
@export var mob_spawner: MobSpawner
@export var wave_duration: float = 20
@export var initial_spawn_rate: float = 60.0
@export var break_instensity: float = 0.5

func _process(delta):
	if GameManager.is_game_over: return
	
	time += delta
	
	#Dificuldade linear
	var spawn_rate = initial_spawn_rate + spawn_rate_per_minute * (time / 60.0)
	
	#Sistema de ondas 
	var sin_wave = sin((time * TAU) / wave_duration)
	var wave_factor = remap(sin_wave, -1.0, 1.0, break_instensity, 1)
	spawn_rate *= wave_factor
	
	#Aplicando a dificuldade
	mob_spawner.mobs_per_minute = spawn_rate
