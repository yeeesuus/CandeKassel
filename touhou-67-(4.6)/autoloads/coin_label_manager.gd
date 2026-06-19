extends Node

signal refresh_coin_counter
signal player_won
signal player_lost

var coins: int = 0
var max_coins: int = 10

func add_coin():
	coins += 1
	refresh_coin_counter.emit()

	if coins >= max_coins:
		player_won.emit()

func player_died() -> void:
	player_lost.emit()
