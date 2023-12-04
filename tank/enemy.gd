extends "res://tank/tank.gd"

var player_pos = Vector2.ZERO

func control(delta):
	look_at(player_pos)
	velocity = Vector2.ZERO
	var scaled_player_pos = player_pos * delta
	velocity += scaled_player_pos.rotated(rotation)

func control_cannon(delta):
	$cannon.look_at(player_pos)
