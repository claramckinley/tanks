extends Area2D

@export var speed : int
@export var damage : int
@export var lifetime : float

var velocity = Vector2.ZERO

func start(_position, _direction):
	position = _position
	rotation = _direction.angle()
	$LifeTimeTimer.wait_time = lifetime
	velocity = _direction * speed
	
func _physics_process(delta):
	position += velocity * delta / 4

func explode():
	queue_free()

func _on_life_time_timer_timeout():
	explode()

func _on_body_entered(body):
	explode()
	if body.has_method('take_damage'):
		body.take_damage(3)
