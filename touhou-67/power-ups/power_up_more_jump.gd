extends Area2D
@onready var character_p: CharacterBody2D = $"../CharacterP"

func take_power_up(player: CharacterBody2D) -> void:
	#Debug.log("TAKE_POWER_UP")
	
	aplicar_efecto(player)
	
	queue_free()

func aplicar_efecto(player: CharacterBody2D) -> void:
	character_p.jump_speed = 500
