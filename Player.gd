extends Area2D
signal hit

onready var position = get_pos()
export var speed = 400
var screensize
var extents
var vel = Vector2()

func _ready():
	set_fixed_process(true)
	screensize = get_viewport_rect().size
	extents = get_node("CollisionShape2D")
	set_pos(screensize / 2)
	hide()

func start(pos):
	position = pos
	show()
	get_node("CollisionShape2D").set_trigger ( true )

func _fixed_process(delta):
	var input = Vector2(0, 0)
	input.x = Input.is_action_pressed("ui_right") - Input.is_action_pressed("ui_left")
	input.y = Input.is_action_pressed("ui_down") - Input.is_action_pressed("ui_up")
	vel = input.normalized() * speed
	var pos = get_pos() + vel * delta
	pos.x = clamp(pos.x, 0, screensize.x)
	pos.y = clamp(pos.y, 0, screensize.y)
	set_pos(pos)


	
	if vel.x != 0:
		get_node("AnimatedSprite").animation = "right"
		get_node("AnimatedSprite").flip_v = false
		get_node("AnimatedSprite").flip_h = vel.x < 0
	elif vel.y != 0:
		get_node("AnimatedSprite").animation = "up"
		get_node("AnimatedSprite").flip_v = vel.y > 0

func _on_Player_body_enter( body ):
	hide() # Player disappears after being hit
	emit_signal("hit")
	get_node("CollisionShape2D").set_trigger ( false )

