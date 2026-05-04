extends HitboxComponent
@onready var sonido: AudioStreamPlayer = $AudioStreamPlayer

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	area_entered.connect(_on_contacto)
	
func _on_contacto(_area: Area2D) -> void:
	sonido.play()
