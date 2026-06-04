extends Area2D

func take_power_up(player: CharacterBody2D) -> void:
	Debug.log("TAKE_POWER_UP")
	queue_free()
