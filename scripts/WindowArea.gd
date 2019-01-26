extends Area2D

export (PackedScene) var Cup
var is_active = false;

func _ready():
	pass

func _process(delta):
	if is_active and Input.is_action_just_pressed("ui_cancel"):
		var cup = Cup.instance()
		add_child(cup)


func _on_WindowArea_body_entered(body):
	print (body.name)
	if (body.name == "Player"):
		is_active = true


func _on_WindowArea_body_exited(body):
	if (body.name == "Player"):
		is_active = false
