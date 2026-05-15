extends HitboxComponent
@onready var sonido: AudioStreamPlayer = $AudioStreamPlayer

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	area_entered.connect(on_contacto)
	
func on_contacto() -> void:
	sonido.play()
