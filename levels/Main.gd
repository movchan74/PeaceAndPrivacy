extends Node2D

export (PackedScene) var Visitor

# class member variables go here, for example:
# var a = 2
# var b = "textvar"

func _ready():
	# Called when the node is added to the scene for the first time.
	# Initialization here
	$VisitorSpawnTimer.start()
	
func find_door_path(from_pos):
	return $VisitorNavigation.get_simple_path(from_pos, $Door.position) # get_position_in_parent())

#func _process(delta):
#	# Called every frame. Delta is time since last frame.
#	# Update game logic here.
#	pass

func _on_VisitorSpawnTimer_timeout():
	print('Got timeout')
	$VisitorSpawnPath/VisitorSpawnLocation.set_offset(randi())
	# Create a Visitor instance and add it to the scene.
	var visitor = Visitor.instance()
	add_child(visitor)
	# Set the mob's position to a random location.
	var visitor_position = $VisitorSpawnPath/VisitorSpawnLocation.position
	print(visitor_position)
	visitor.position = visitor_position
	visitor.init_path()