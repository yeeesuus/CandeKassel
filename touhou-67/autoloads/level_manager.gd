extends Node

@export var main_menu_scene: PackedScene
@export var credits_scene: PackedScene
@export var levels: Array[PackedScene]

@export var power_ups: Array[BasePowerUp]

var current_level = 0

func start() -> void:
	current_level = 0
	get_tree().change_scene_to_packed(levels[0])

func next_level() -> void:
	current_level+=1
	if current_level < levels.size():
		get_tree().change_scene_to_packed(levels[current_level])
	else:
		get_tree().change_scene_to_packed(main_menu_scene)
		
func last_level() -> void:
	if current_level == 0:
		for bala in get_tree().get_nodes_in_group("balas"):
			bala.queue_free()
		get_tree().reload_current_scene()
	else:
		current_level -= 1
		get_tree().change_scene_to_packed(levels[current_level])

func main_menu() -> void:
	get_tree().change_scene_to_packed(main_menu_scene)

func credits() -> void:
	get_tree().change_scene_to_packed(credits_scene)

func random_power_up() -> BasePowerUp:
	return power_ups.pick_random()
