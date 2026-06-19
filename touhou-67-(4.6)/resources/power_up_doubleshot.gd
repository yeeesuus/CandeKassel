class_name DoubleShot

extends BasePowerUp

@export var amount: int = 1

func aplicar_efecto(player: CharacterBody2D) -> void:
	player.power_up_doble = true
