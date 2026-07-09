extends Area2D

@onready var icon: Sprite2D = $Icon
@onready var power_up_sound: AudioStreamPlayer = $PowerUpSound

var power_up: BasePowerUp

func _ready() -> void:
	power_up = LevelManager.random_power_up()
	_update()
	
func _update() -> void:
	icon.texture = power_up.textura

func take_power_up(player: CharacterBody2D) -> void:
	#Debug.log("TAKE_POWER_UP")
	power_up.aplicar_efecto(player)
	player.sonido_power_up()
	queue_free()
