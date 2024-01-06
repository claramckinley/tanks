extends "res://tank/tank.gd"

signal player_hit

func control(delta):
	var rot_dir = 0
	if Input.is_action_pressed("right"):
		rot_dir += 1
	if Input.is_action_pressed("left"):
		rot_dir -= 1
	rotation += rotation_speed * rot_dir * delta
	velocity = Vector2.ZERO
	if Input.is_action_pressed("up"):
		velocity = Vector2(speed, 0).rotated(rotation)
	if Input.is_action_pressed("down"):
		velocity = Vector2(-speed/2, 0).rotated(rotation)
	if Input.is_action_just_pressed("shoot"):
		check_shoot()

func control_cannon(delta):
	var cannon_rot_dir = 0
	if Input.is_action_pressed("spin_right"):
		cannon_rot_dir += 1
	if Input.is_action_pressed("spin_left"):
		cannon_rot_dir -= 1
	$cannon.rotation += rotation_speed * cannon_rot_dir * delta


func _on_gun_timer_timeout():
	can_shoot = true
	
func take_damage(damage):
	if health_bar.value - damage < 0:
		queue_free()
	else:
		health_bar.value = health_bar.value - damage
	emit_signal('player_hit')
