extends Node2D

export (PackedScene) var Visitor
export var min_spawn_time = 2.0
export var max_spawn_time = 5.0
var score = 0

func _ready():
	# Called when the node is added to the scene for the first time.
	# Initialization here
	randomize()
	$VisitorSpawnTimer.start()
	
func find_door_path(from_pos):
	return $VisitorNavigation.get_simple_path(from_pos, $Door.position, false)

func find_path(from_pos, to_pos):
	return $VisitorNavigation.get_simple_path(from_pos, to_pos, false)

#func _process(delta):
#	# Called every frame. Delta is time since last frame.
#	# Update game logic here.
#	pass

func _on_VisitorSpawnTimer_timeout():
	$VisitorSpawnPath/VisitorSpawnLocation.set_offset(randi())
	# Create a Visitor instance and add it to the scene.
	var visitor = Visitor.instance()
	$Visitors.add_child(visitor)
	# Set the mob's position to a random location.
	var visitor_position = $VisitorSpawnPath/VisitorSpawnLocation.position
	visitor.position = visitor_position
	visitor.init_path()
	$VisitorSpawnTimer.wait_time = randf()*(max_spawn_time-min_spawn_time)+min_spawn_time
	$VisitorSpawnTimer.start()
	
func game_over(text):
	$BackgroundMusic.stop()
	$DoorBell.play()
	get_tree().paused = true
	$HUD/GameOver.text = text
	$HUD/GameOver.show()
	$HUD/RestartGame.show()
	
func update_score_label():
	$HUD/Score.text = str(score)
	
func restart_game():
	print ("restart")
	$DoorBell.stop()
	$BackgroundMusic.play()
	score = 0
	update_score_label()
	$HUD/GameOver.hide()
	$HUD/RestartGame.hide()
	for child in $Visitors.get_children():
		child.queue_free()
	get_tree().paused = false

func inc_score():
	score += 1
	update_score_label()
	
	
	