extends HitboxComponent

@onready var timer: Timer = $Timer
@export var speed = 400
var delta_acc = 0

func _ready() -> void:
	timer.timeout.connect(func():queue_free())
	
func _physics_process(delta: float) -> void:
	#es acá donde se cambia el patrón
	delta_acc += delta*5
	var direction = +global_transform.y
	global_position += direction * speed * delta
	global_position+=direction
