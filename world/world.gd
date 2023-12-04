extends Node2D

@onready var player = $player
@onready var enemy = $enemy

func _process(delta):
	enemy.player_pos = player.position
