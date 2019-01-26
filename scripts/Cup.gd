extends Area2D

export (int) var speed
var velocity = Vector2(0, 1)
var is_local = true

func init(v, l):
	velocity = v
	is_local = l

func _ready():
	# Called when the node is added to the scene for the first time.
	# Initialization here
	pass

func _process(delta):
	if is_local:
		position += velocity * delta * speed
	else:
		global_position += velocity * delta * speed
#	position.x
#	# Called every frame. Delta is time since last frame.
#	# Update game logic here.
#	pass
