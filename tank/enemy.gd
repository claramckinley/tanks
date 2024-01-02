extends "res://tank/tank.gd"

var player_pos = Vector2.ZERO
var known_pos = null
var target

func control(delta):
	if known_pos != null:
		update_current_target(delta)

func _on_detect_radius_body_entered(body):
	if body.is_in_group('player'):
		known_pos = player_pos
	
func _on_detect_radius_body_exited(_body):
	target = null
	known_pos = null

func update_current_target(delta):
	var target_node: Node
	if $RayCast2D.is_colliding():
		var item = $RayCast2D.get_collider()
		if item.is_in_group('player'):
			if clear_shot(item):
				target_node = item
				follow(delta)
			else:
				target_node = null
		else:
			target_node = null
	else:
		target_node = null
	target = target_node
	
func clear_shot(target: Node):
	var space_state = get_world_2d().direct_space_state
	var result = space_state.intersect_ray(PhysicsRayQueryParameters2D.create(global_position, target.global_position))
	return result.collider == target
	
func follow(_delta):
	look_at(player_pos)
	bullet = preload("res://bullet/enemy_bullet.tscn")
	if player_pos != null:
		check_shoot()
	
func search(delta):
	velocity = Vector2.ZERO
	var scaled_player_pos = player_pos * delta
	velocity += scaled_player_pos.rotated(rotation)
	
