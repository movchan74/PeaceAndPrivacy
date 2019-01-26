extends Area2D

# class member variables go here, for example:
# var a = 2
# var b = "textvar"
var current_area
var screensize
var visitorFollowPath
var speed = 0.1
var is_paused = false

func _ready():
	get_node("/root/Main/Player").connect("shout", self, "_on_Player_shout")
	screensize = get_viewport_rect().size

func get_door_path():
	return get_parent().find_door_path(self.position) # get_pos())
	
func init_path():
	var path = get_door_path()
	var curve = Curve2D.new()
	for point in path:
		curve.add_point(point)
	var visitorPath = Path2D.new()
	visitorPath.curve = curve
	add_child(visitorPath)
	visitorFollowPath = PathFollow2D.new()
	visitorPath.add_child(visitorFollowPath)
	
func _process(delta):
	if not is_paused:
		if (visitorFollowPath != null):
			visitorFollowPath.unit_offset += speed * delta
			self.position = visitorFollowPath.position
			

func _on_Visitor_area_shape_entered(area_id, area, area_shape, self_shape):
	#print (area.name)
	if ("Cup" in area.name):
		queue_free()
	if ("WindowArea" in area.name):
		current_area = area
		current_area.register_visitor(self)

func _on_Player_shout():
	#print (current_area)
	if current_area != null:
		if (current_area.is_active):
			#print (position, screensize)
			var min_x_dist = min(screensize.x - position.x, position.x)
			var min_y_dist = min(screensize.y - position.y, position.y)
			var escape_point;
			if min_x_dist < min_y_dist:
				var x_escape;
				if screensize.x - position.x < position.x:
					x_escape = screensize.x
				else:
					x_escape = 0
				escape_point = Vector2(x_escape, position.y)
			else:
				var y_escape;
				if screensize.y - position.y < position.y:
					y_escape = screensize.y
				else:
					y_escape = 0
				escape_point = Vector2(position.x, y_escape)	
			#print (escape_point)
			print ("visitor is surprised")
			is_paused = true
			

func _on_Visitor_area_shape_exited(area_id, area, area_shape, self_shape):
	if area != null:
		if ("WindowArea" in area.name):
			if current_area != null:
				current_area.unregister_visitor(self)
			current_area = null
