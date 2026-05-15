extends CharacterBody2D
@onready var audio_stream_player: AudioStreamPlayer = $AudioStreamPlayer

var vida: int = 10

func take_damage(value: int) -> void:
	vida -= value
	if vida <= 0:
		audio_stream_player.play()
		await get_tree().create_timer(0.05).timeout
		queue_free()
