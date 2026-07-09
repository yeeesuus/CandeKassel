extends Node

@onready var musica_menu: AudioStreamPlayer = $SoundMain_Credits
@onready var musica_juego: AudioStreamPlayer = $SoundLevel

enum EstadoMusica { MENU, JUEGO, NINGUNO }

var estado_actual: EstadoMusica = EstadoMusica.NINGUNO

func reproducir_musica(nuevo_estado: EstadoMusica):
	if estado_actual == nuevo_estado:
		return

	apagar_toda_la_musica()
	
	estado_actual = nuevo_estado
	if estado_actual == EstadoMusica.MENU:
		musica_menu.play()
	elif estado_actual == EstadoMusica.JUEGO:
		musica_juego.play()

func apagar_toda_la_musica():
	musica_menu.stop()
	musica_juego.stop()
