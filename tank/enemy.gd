extends "res://tank/tank.gd"

var player_pos = Vector2.ZERO
var known_pos = null
var found_player = false
var missed_player = true

enum State {
	CHASE,
	WANDER,
	RUN
}

@onready var wander_timer = $WanderTimer

var enemy_state = State.WANDER

func control(delta):
	match enemy_state:
		State.CHASE:
			chase(delta)
			focus_on_target()
		State.WANDER:
			pass
#			wander(delta)
		State.RUN:
			run(delta)
		

func _on_detect_radius_body_entered(body):
	if body.is_in_group('player'):
		found_player = true
	
func _on_detect_radius_body_exited(_body):
	known_pos = null
	enemy_state = State.CHASE

func update_current_target(_delta):
	var target_node: Node
	if $RayCast2D.is_colliding():
		var item = $RayCast2D.get_collider()
		if item.is_in_group('player'):
			if clear_shot(item):
				target_node = item
#				follow(delta)
			else:
				target_node = null
		else:
			target_node = null
	else:
		target_node = null
#	target = target_node
	
func clear_shot(target: Node):
	var space_state = get_world_2d().direct_space_state
	var result = space_state.intersect_ray(PhysicsRayQueryParameters2D.create(global_position, target.global_position))
	return result.collider == target
	
func chase(delta):
	velocity = Vector2.ZERO
	var scaled_player_pos = player_pos * delta
	velocity += scaled_player_pos.rotated(rotation)
	
func run(delta):
	velocity = Vector2.ZERO
	var scaled_player_pos = player_pos * delta
	velocity += scaled_player_pos.rotated(-1 * rotation)
	
func wander(delta):
	wander_timer.wait_time = randi_range(1,4)
	wander_timer.start()
	velocity = Vector2.ZERO
	var scaled_player_pos = player_pos * delta
	velocity += scaled_player_pos.rotated(-1 * rotation)

func take_damage(damage):
	if health_bar.value - damage < 0:
		queue_free()
	else:
		health_bar.value = health_bar.value - damage
	enemy_state = State.RUN
		
func focus_on_target():
	known_pos = player_pos
	look_at(known_pos)
	bullet = preload("res://bullet/enemy_bullet.tscn")
	check_shoot()

func _on_player_player_hit():
	missed_player = false


func _on_wander_timer_timeout():
	pass # Replace with function body.
