extends CharacterBody2D
@onready var escudo: Area2D = $escudo
@onready var escudo_timer: Timer = $EscudoTimer
@onready var pivote_escudo: Node2D = $pivoteescudo
@onready var audio_stream_player: AudioStreamPlayer = $AudioStreamPlayer
var vida: int = 10

func _ready() -> void:
	escudo_timer.timeout.connect(_girar_escudo)
	escudo_timer.start()

func take_damage(value: int) -> void:
	vida -= value
	if vida <= 0:
		audio_stream_player.play()
		await get_tree().create_timer(0.05).timeout
		queue_free()
	
func _girar_escudo() -> void:
	pivote_escudo.scale.x = pivote_escudo.scale.x*-1
	escudo_timer.start()
