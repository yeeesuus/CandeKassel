extends CharacterBody2D

var vida: int = 10

func take_damage(value: int) -> void:
	vida -= value
	if vida <= 0:
		queue_free()
