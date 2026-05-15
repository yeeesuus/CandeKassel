extends HitboxComponent

@onready var timer: Timer = $Timer
@export var speed = 600

func _ready() -> void:
	timer.timeout.connect(func():queue_free())
	
func _physics_process(delta: float) -> void:
	var direction = +global_transform.y
	global_position += direction * speed * delta
