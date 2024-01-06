extends CharacterBody2D

signal health_change
signal died
signal shoot(bullet, pos, dir)

@export var speed : int
@export var rotation_speed : int
@export var gun_cooldown : int
@export var health : int
@export var bullet : PackedScene = preload("res://bullet/bullet.tscn")

@onready var health_bar = $ProgressBar

var can_shoot = true
var alive = true

func _ready():
	$GunTimer.wait_time = gun_cooldown
	health_bar.max_value = health
	health_bar.value = health
	
func control(delta):
	pass
	
func control_cannon(delta):
	pass

func take_damage(damage):
	pass
	
func _physics_process(delta):
	if not alive:
		return
	control(delta)
	control_cannon(delta)
	move_and_slide()
	
func check_shoot():
	if can_shoot:
		can_shoot = false
		$GunTimer.start()
		var dir = Vector2(1,0).rotated($cannon.global_rotation + deg_to_rad(-90))
		emit_signal('shoot', bullet, $cannon/muzzle.global_position, dir)
		

func _on_gun_timer_timeout():
	can_shoot = true
		
