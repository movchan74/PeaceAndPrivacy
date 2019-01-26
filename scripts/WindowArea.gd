extends Area2D

export (PackedScene) var Cup
var is_active = false
var active_visitors = []

func _ready():
	pass

func _process(delta):
	if is_active and Input.is_action_just_pressed("ui_cancel"):
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
