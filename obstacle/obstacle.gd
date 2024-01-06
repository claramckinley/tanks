extends StaticBody2D

@onready var sprite_2d = $Sprite2D

# Called when the node enters the scene tree for the first time.
func _ready():
	randomize()
	sprite_2d.frame = randi_range(0,2)


func _on_area_2d_body_entered(body):
	if body.is_in_group('player'):
		
