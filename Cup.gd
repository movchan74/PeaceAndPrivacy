extends Area2D

export (int) var speed

func _ready():
	# Called when the node is added to the scene for the first time.
	# Initialization here
	pass

func _process(delta):
	var velocity = Vector2(0, 1)
	position += velocity * delta * speed
#	position.x
#	# Called every frame. Delta is time since last frame.
#	# Update game logic here.
#	pass
