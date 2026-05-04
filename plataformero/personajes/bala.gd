extends HitboxComponent

@export var speed: int = 600
@onready var timer: Timer = $Timer

func _ready() -> void:
	area_entered.connect(_on_impacto)
	timer.timeout.connect(func():queue_free())

func _on_impacto(_area: Area2D) -> void:
	if _area is HitboxComponent:
		_area.on_contacto()
		queue_free()

	if _area is Hurtbox:
		queue_free()
		
func _physics_process(delta: float) -> void:
	var direction = global_transform.x
	position += direction*speed*delta
