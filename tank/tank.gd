extends CharacterBody2D

signal health_change
signal died

var bullet = preload("res://bullet/bullet.tscn")
@export var speed : int
@export var rotation_speed : int
@export var gun_cooldown : int
@export var health : int

var can_shoot = true
var alive = true
	
func control(delta):
	pass
	
func control_cannon(delta):
	pass
	
func check_shoot():
	pass
	
func _physics_process(delta):
	if not alive:
		return
	control(delta)
	control_cannon(delta)
	check_shoot()
	move_and_slide()
