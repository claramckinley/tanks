extends Node2D

@onready var player = $player
@onready var enemy = $enemy

func _physics_process(delta):
	if player != null:
		enemy.player_pos = player.global_position

func _on_tank_shoot(bullet, pos, dir):
	var instance = bullet.instantiate()
	add_child(instance)
	instance.start(pos, dir)
