extends KinematicBody2D

# class member variables go here, for example:
# var a = 2
# var b = "textvar"

func _ready():
	# Called when the node is added to the scene for the first time.
	# Initialization here
	pass

func _process(delta):
	if Input.is_action_pressed("ui_right"):
		$AnimatedSprite.play("idle")
		$AnimatedSprite/AnimationPlayer.play("idle")
	if Input.is_action_pressed("ui_left"):
		$AnimatedSprite.play("shout")
		$AnimatedSprite/AnimationPlayer.play("shout_wiggle")
	if Input.is_action_pressed("ui_down"):
		$AnimatedSprite.play("walk")
		$AnimatedSprite/AnimationPlayer.play("walk_wiggle")