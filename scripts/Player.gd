extends KinematicBody2D
signal shout

export (int) var speed
var screensize

func _ready():
	screensize = get_viewport_rect().size

func _process(delta):
	var velocity = Vector2() # The player's movement vector.
	if Input.is_action_pressed("ui_right"):
		velocity.x += 1
	if Input.is_action_pressed("ui_left"):
		velocity.x -= 1
	if Input.is_action_pressed("ui_down"):
		velocity.y += 1
	if Input.is_action_pressed("ui_up"):
		velocity.y -= 1
		
	if Input.is_action_just_pressed("ui_select"):
		emit_signal("shout")
		$Sprite.play("shout")
		$Sprite/AnimationPlayer.play("shout_wiggle")
		$ShoutTimer.start()

	velocity = velocity.normalized() * speed
	var collision = move_and_collide(velocity)
	if collision == null and velocity.length() > 0:
		if $Sprite.animation != "walk":
			$Sprite.play("walk")
			$Sprite/AnimationPlayer.play("walk_wiggle")
	else:
		$Sprite.play("idle")
		$Sprite/AnimationPlayer.play("idle")
#	position += velocity * delta
#	position.x = clamp(position.x, 0, screensize.x)
#	position.y = clamp(position.y, 0, screensize.y)


func _on_ShoutTimer_timeout():
	$Sprite.play("idle")
	$Sprite/AnimationPlayer.play("idle")
