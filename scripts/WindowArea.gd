extends Area2D

export (PackedScene) var Cup
var is_active = false
var active_visitors = []
var can_throw = true

func _ready():
	get_node("/root/Main/Player").connect("shout", self, "_on_Player_shout")

func _process(delta):
	if is_active and can_throw and Input.is_action_just_pressed("ui_cancel"):
		print (active_visitors)
		var min_dist = 100000;
		var closest_visitor;
		for visitor in active_visitors:
			if self.global_position.distance_to(visitor.global_position) < min_dist and visitor.current_area != null:
				closest_visitor = visitor
				min_dist = self.global_position.distance_to(visitor.global_position)
		var cup = Cup.instance()
		if closest_visitor != null:
			print (closest_visitor.is_paused)
			var direction = (closest_visitor.global_position - self.global_position).normalized()
			cup.init(direction, false)
		add_child(cup)
		can_throw = false
		$CupThrowTimer.start()


func _on_WindowArea_body_entered(body):
	#print (body.name)
	if (body.name == "Player"):
		is_active = true


func _on_WindowArea_body_exited(body):
	if (body.name == "Player"):
		is_active = false
		
func register_visitor(visitor):
	active_visitors.append(visitor)

func unregister_visitor(visitor):
	active_visitors.erase(visitor)

func _on_CupThrowTimer_timeout():
	can_throw = true
	
func _on_Player_shout():
	if is_active:
		$Wave/AnimatedSprite.frame = 0
		$Wave/AnimatedSprite.play("default")