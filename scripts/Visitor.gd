extends Area2D

# class member variables go here, for example:
# var a = 2
# var b = "textvar"
var current_area
var screensize
var visitorFollowPath
export var speed = 100
export (Array) var variations
export (Array) var variations_text
var is_paused = false
var text

func _ready():
	get_node("/root/Main/Player").connect("shout", self, "_on_Player_shout")
	screensize = get_viewport_rect().size
	$Sprite/AnimationPlayer.play("walk_wiggle")
	var i = randi() % variations.size()
	$Sprite.frames = variations[i]
	text = variations_text[i]

func get_door_path():
	return get_parent().get_parent().find_door_path(self.position) # get_pos())
	
func init_path():
	var path = get_door_path()
	var curve = Curve2D.new()
	for point in path:
		curve.add_point(point)
	var visitorPath = Path2D.new()
	visitorPath.curve = curve
	add_child(visitorPath)
	visitorFollowPath = PathFollow2D.new()
	visitorFollowPath.loop = false
	visitorPath.add_child(visitorFollowPath)

func update_path(path):
	var curve = Curve2D.new()
	for point in path:
		curve.add_point(point)
	visitorFollowPath.get_parent().curve = curve
	
func _process(delta):
	#print (current_area)
	if not is_paused:
		if (visitorFollowPath != null):
			visitorFollowPath.offset += speed * delta
			self.position = visitorFollowPath.position
			if visitorFollowPath.unit_offset > 0.99:
				queue_free()

func _on_Visitor_area_shape_entered(area_id, area, area_shape, self_shape):
	#print (area.name)
	if ("Door" == area.name):
		get_node("/root/Main").game_over(text)
		print ("Game over!")
		queue_free()
	if ("Cup" in area.name or "Plant" in area.name):
		$GroanSound.play()
		get_node("/root/Main").inc_score()
		var new_path = get_parent().get_parent().find_path(self.position, get_escape_point())
		print (new_path)
		update_path(new_path)
		is_paused = false
		visitorFollowPath.unit_offset = 0
		area.queue_free()
		$Sprite.play("hit")
		$Sprite/AnimationPlayer.play("walk_wiggle")
		#queue_free()
	if ("WindowArea" in area.name):
		if area != null:
			current_area = area
			current_area.register_visitor(self)

func get_escape_point():
	var min_x_dist = min(screensize.x - position.x, position.x)
	var min_y_dist = min(screensize.y - position.y, position.y)
	var escape_point;
	if min_x_dist < min_y_dist:
		var x_escape;
		if screensize.x - position.x < position.x:
			x_escape = screensize.x + 500
		else:
			x_escape = -500
		escape_point = Vector2(x_escape, position.y)
	else:
		var y_escape;
		if screensize.y - position.y < position.y:
			y_escape = screensize.y + 500
		else:
			y_escape = -500
		escape_point = Vector2(position.x, y_escape)
	return escape_point

func _on_Player_shout():
	print (current_area)
	if current_area != null:
		if (current_area.is_active):
			is_paused = true
			$PausedTimer.start()
			$Sprite/AnimationPlayer.play("idle")
			

func _on_Visitor_area_shape_exited(area_id, area, area_shape, self_shape):
	if area != null:
		if ("WindowArea" in area.name) and current_area != null:
			current_area.unregister_visitor(self)
			current_area = null

func _on_PausedTimer_timeout():
	is_paused = false
	$Sprite/AnimationPlayer.play("walk_wiggle")
