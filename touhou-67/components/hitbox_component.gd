class_name HitboxComponent
extends Area2D

signal damage_dealt

@export var damage: int = 1

func _ready() -> void:
	area_entered.connect(_on_area_entered)

func _on_area_entered(area: Area2D) -> void:
	if area is HurtboxComponent and area.owner.name.match("PowerUp*"):
		if owner.has_method("collect_power_up"):
			#Debug.log("MM COLLECT_POWER_UP")
			owner.collect_power_up()
		if area.owner.has_method("take_power_up"):
			#Debug.log("MM TAKE_POWER_UP")
			area.owner.take_power_up(owner)
	
	if area is HitboxComponent:
		#Debug.log("damage received")
		if owner.has_method("take_damage"):
			owner.take_damage(area.damage)
