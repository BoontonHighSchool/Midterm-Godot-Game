extends RigidBody2D

export (int) var MIN_SPEED
export (int) var MAX_SPEED
var mob_types = ["walk", "swim", "fly"]

func _ready():
	get_node("AnimatedSprite").animation = mob_types[randi() % mob_types.size()]

func _on_Visibility_exit_screen():
	queue_free()