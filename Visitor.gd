extends Area2D

# class member variables go here, for example:
# var a = 2
# var b = "textvar"
var current_area;

func _ready():
	# Called when the node is added to the scene for the first time.
	# Initialization here
	pass

#func _process(delta):
#	# Called every frame. Delta is time since last frame.
#	# Update game logic here.
#	pass


func _on_Visitor_area_shape_entered(area_id, area, area_shape, self_shape):
	print (area.name)
	if (area.name == "Cup"):
		queue_free()
	else:
		current_area = area

func _on_Player_shout():
	#print (current_area.is_active)
	if (current_area.is_active):
		print ("visitor is surprised")


func _on_Visitor_area_shape_exited(area_id, area, area_shape, self_shape):
	current_area = null
